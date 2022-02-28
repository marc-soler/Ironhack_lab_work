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
