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
    rank = np.arange(len(soup.select("div.o-chart-results-list-row-container")))+1
    # creating a DataFrame
    return pd.DataFrame({
        'rank': rank,
    'song_title': titles,
    'artists': artists,
    'weeks_on_chart': weeks
    })

def levenshtein_ratio(s, t, ratio_calc = False):
    import numpy as np
    rows = len(s)+1
    cols = len(t)+1
    distance = np.zeros((rows,cols),dtype = int)
    for i in range(1, rows):
        for k in range(1,cols):
            distance[i][0] = i
            distance[0][k] = k
    for col in range(1, cols):
        for row in range(1, rows):
            if s[row-1] == t[col-1]:
                cost = 0
            else:
                if ratio_calc == True:
                    cost = 2
                else:
                    cost = 1
            distance[row][col] = min(distance[row-1][col] + 1,
                                 distance[row][col-1] + 1,
                                 distance[row-1][col-1] + cost)
    if ratio_calc == True:
        Ratio = ((len(s)+len(t)) - distance[row][col]) / (len(s)+len(t))
        return Ratio

def recommender_hot100():
    import pandas as pd
    song = input('Write the title of a song you like to find similar ones: ')
    print('Getting the data...')
    df = top100()
    best_match = ()
    for index,name in df['song_title'].iteritems():
        ratio = levenshtein_ratio(name, song, ratio_calc=True)
        if len(best_match) == 0:
            best_match = (index, ratio)
        else:
            if ratio > best_match[1]:
                best_match = (index, ratio)
    cond = True
    while cond:
        prompt = input(f'Do you mean {df.iloc[best_match[0]].song_title} by {df.iloc[best_match[0]].artists}? Type yes/no: ')
        if prompt.lower() == 'yes':
            pick = df.drop(best_match[0]).sample()
            song_title = pick.song_title.item()
            artist = pick.artists.item()
            recommendation = f'{song_title} by {artist}'
            print(f'Nice choice! Try listening to {recommendation}')
            cond = False
        elif prompt.lower() == 'no':
            print("Sorry, I can't recommend a song :(")
            cond = False
        else:
            print("Sorry, I didn't catch that, you need to type either 'yes' or 'no'.")
