def top100():
    # imports
    import pandas as pd
    import numpy as np
    import requests
    from bs4 import BeautifulSoup
    # BeautifulSoup setup
    url = 'https://www.billboard.com/charts/hot-100/'
    headers = {"Accept-Language": "en-US,en;q=0.5"}
    page = requests.get(url, headers=headers)
    soup = BeautifulSoup(page.content, 'html.parser')
    # paths & empty lists
    title_path = 'h3.c-title.a-no-trucate'
    artist_path = 'span.c-label.a-no-trucate.a-font-primary-s'
    weeks_path = 'ul > li.lrv-u-width-100p > ul > li.lrv-u-width-100p.u-hidden\@tablet > ul > li:nth-child(5) > span'
    titles = []
    artists = []
    weeks = []
    # getting the data
    for i in range(len(soup.select("div.o-chart-results-list-row-container"))):
        titles.append(soup.select(title_path)[i].get_text(strip=True))
        artists.append(soup.select(artist_path)[i].get_text(strip=True))
        weeks.append(soup.select(weeks_path)[i].get_text(strip=True))
    # adding a rank
    rank = np.arange(len(soup.select("div.o-chart-results-list-row-container"))) + 1
    # creating a DataFrame
    return pd.DataFrame({
        'rank': rank,
        'song_title': titles,
        'artists': artists,
        'weeks_on_chart': weeks
    })


def levenshtein_ratio(s, t, ratio_calc=False):
    import numpy as np
    rows = len(s) + 1
    cols = len(t) + 1
    distance = np.zeros((rows, cols), dtype=int)
    for i in range(1, rows):
        for k in range(1, cols):
            distance[i][0] = i
            distance[0][k] = k
    for col in range(1, cols):
        for row in range(1, rows):
            if s[row - 1] == t[col - 1]:
                cost = 0
            else:
                if ratio_calc:
                    cost = 2
                else:
                    cost = 1
            distance[row][col] = min(distance[row - 1][col] + 1,
                                     distance[row][col - 1] + 1,
                                     distance[row - 1][col - 1] + cost)
    if ratio_calc:
        ratio = ((len(s) + len(t)) - distance[row][col]) / (len(s) + len(t))
        return ratio


def spotify_display(song_name_id):
    from IPython.core.display import display
    from IPython.display import IFrame
    display(IFrame(src=f"https://open.spotify.com/embed/track/{song_name_id}",
                   width="320",
                   height="80",
                   frameborder="0",
                   allowtransparency="true",
                   allow="encrypted-media", ))


def recommender():
    # Imports
    import spotipy
    from spotipy.oauth2 import SpotifyClientCredentials
    import getpass
    import random
    from tqdm import tqdm
    # global variables & spotipy connection
    client_id = str(getpass.getpass('client_id?'))
    client_secret = str(getpass.getpass('client_secret?'))
    client_credentials_manager = SpotifyClientCredentials(client_id, client_secret)
    sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)
    print('\nGetting the data...')
    top = tqdm(top100())
    avail_genres = sp.recommendation_genre_seeds()['genres']
    # Main loop
    go_again = True
    while go_again:
        song = input("Tell me a song you really like and I'll tell you some similar ones! You can tell me the title "
                     "and the artist, or only the title!: ")
        best_match = ()
        # Getting the best match from billboard Hot100 using Levenshtein's ratio
        for index, name in top['song_title'].iteritems():
            ratio = levenshtein_ratio(name, song, ratio_calc=True)
            if len(best_match) == 0:
                best_match = (index, ratio)
            else:
                if ratio > best_match[1]:
                    best_match = (index, ratio)
        # Check if song in Hot100, then Spotify recommendations
        while True:
            print('\nOkay, I was looking in the Billboard Hot 100 list and I found something!')
            prompt = input(
                f'Do you mean {top.iloc[best_match[0]].song_title} by {top.iloc[best_match[0]].artists}? Type yes/no: ')
            # Song in Hot100, recommend 3 random songs from spotify due to poor music taste
            if prompt.lower() == 'yes':
                print("\nHmm... I'm sorry to break it to you darling, but your taste in music kinda sucks :(")
                print("\nHowever, don't worry! I'm here to assist you. I'm getting you some random recommendation from "
                      "Spotify to diversify your repertoire a bit")
                print("\nThe songs I chose for you are the following, you can even have a brief taste of them "
                      "now. Enjoy!")
                for i in range(3):
                    random_genre = random.choice(avail_genres)
                    recom = sp.recommendations(seed_genres=[random_genre], limit=1)
                    song_recom = recom['tracks'][0]['name']
                    artist_recom = recom['tracks'][0]['artists'][0]['name']
                    recom_id = recom['tracks'][0]['id']
                    print(f"\n - {song_recom} by {artist_recom}")
                    spotify_display(recom_id)
                break
            # Song not in Hot100, search in Spotify and promp user to confirm again
            elif prompt.lower() == 'no':
                print("\nNice! Your song is not a basic, mainstream one. Let's look if I can find it in Spotify!")
                song_sp = sp.search(song, type='track')
                # No results returned, no match
                if len(song_sp['tracks']['items']) == 0:
                    print("\nSorry, I can't seem to find your song in Spotify...")
                # Match
                else:
                    while True:
                        song_name = song_sp['tracks']['items'][0]['name']
                        artist_name = song_sp['tracks']['items'][0]['artists'][0]['name']
                        prompt = input(f"\nI got a match! Are you referring to the song {song_name} by {artist_name}? "
                                       f"Type yes/no: ")
                        if prompt.lower() == 'yes':
                            # Checking the genre of the song
                            track_ex = song_sp['tracks']['items'][0]
                            artist_ex = sp.artist(track_ex["artists"][0]["external_urls"]["spotify"])
                            genres = artist_ex['genres']
                            # If no genres, recommend just by the title of the song
                            if len(list(genres)) == 0:
                                print("\nHere are your fresh recommendations, ejoy :)")
                                song_id = song_sp['tracks']['items'][0]['id']
                                recom = sp.recommendations(seed_tracks=[song_id], limit=3)['tracks']
                                for track in recom:
                                    song_recom = track['name']
                                    artist_recom = track['artists'][0]['name']
                                    recom_id = track['id']
                                    print(f"\n - {song_recom} by {artist_recom}")
                                    spotify_display(recom_id)
                            else:
                                print(f"\nAccording to Spotify, your song has the genres: {str(genres)}")
                                # Asking user for same genre
                                while True:
                                    check_genre = input('\nDo you want me to recommend songs from the same genre(s)? '
                                                        'Type yes/no: ')
                                    # Recommend 3 songs based on the song and with the same genre
                                    if check_genre.lower() == 'yes':
                                        print('\nIf it works, why change it I guess! Here are your fresh '
                                              'recommendations, enjoy :)')
                                        song_id = song_sp['tracks']['items'][0]['id']
                                        genres_split = genres[0].split(",")
                                        recom = sp.recommendations(seed_tracks=[song_id],
                                                                   seed_genres=genres_split, limit=3)['tracks']
                                        for track in recom:
                                            song_recom = track['name']
                                            artist_recom = track['artists'][0]['name']
                                            recom_id = track['id']
                                            print(f"\n - {song_recom} by {artist_recom}")
                                            spotify_display(recom_id)
                                        break
                                    # Recommend 3 songs based on the song but each with a different genre
                                    elif check_genre.lower() == 'no':
                                        print("\nI like people who venture into the unknown like yourself! I'm going "
                                              "to do my best to find some fresh tunes for ya. Enjoy them!")
                                        song_id = song_sp['tracks']['items'][0]['id']
                                        for i in range(3):
                                            random_genre = random.choice(avail_genres)
                                            while random_genre in genres:
                                                random_genre = random.choice(avail_genres)
                                            recom = sp.recommendations(seed_tracks=[song_id],
                                                                       seed_genres=[random_genre],
                                                                       limit=1)
                                            song_recom = recom['tracks'][0]['name']
                                            artist_recom = recom['tracks'][0]['artists'][0]['name']
                                            recom_id = recom['tracks'][0]['id']
                                            print(f"\n - {song_recom} by {artist_recom}, a nice {random_genre} song")
                                            spotify_display(recom_id)
                                        break
                                    # Prompt user for yes or no only
                                    else:
                                        print("\nSorry, I didn't catch that, you need to type either 'yes' or 'no'.")
                            break
                        # Not the song the user was looking for
                        elif prompt.lower() == 'no':
                            print("\nI'm sorry, but I can't seem to find the song you're looking for!")
                            break
                        # Prompt user for yes or no only
                        else:
                            print("\nSorry, I didn't catch that, you need to type either 'yes' or 'no'.")
                break
            # Prompt user for yes or no only
            else:
                print("\nSorry, I didn't catch that, you need to type either 'yes' or 'no'.")
        # Go again loop. Checks if the user wants to try again
        while True:
            again = input('\nDo you wanna use the awesome recommender again? Type yes/no: ')
            if again.lower() == 'no':
                go_again = False
                print('\nOk, thanks for using the awesome recommender!')
                break
            elif again.lower() == 'yes':
                break
            else:
                print("\nSorry, I didn't catch that, you need to type either 'yes' or 'no'.")


def get_playlist_features(playlist_id):
    import spotipy
    from spotipy.oauth2 import SpotifyClientCredentials
    import getpass
    import pandas as pd
    client_id = str(getpass.getpass('client_id?'))
    client_secret = str(getpass.getpass('client_secret?'))
    client_credentials_manager = SpotifyClientCredentials(client_id, client_secret)
    sp = spotipy.Spotify(client_credentials_manager=client_credentials_manager)
    songs = []
    feats = []
    feats_df = pd.DataFrame()
    playlist = sp.playlist_tracks(playlist_id)
    for i in playlist['items']:
        songs.append(i['track']['id'])
    while playlist['next']:
        playlist = sp.next(playlist)
        for i in playlist['items']:
            songs.append(i['track']['id'])
    for i in range(0, len(songs), 100):
        x = sp.audio_features(tracks=songs[i:i + 100])
        for f in x:
            feats.append(f)
    for feat in feats:
        feats_df = feats_df.append(feat, ignore_index=True)
    return feats_df
