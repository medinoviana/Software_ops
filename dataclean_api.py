# Import librari yang diperlukan
import requests
import pandas as pd


def get_universities_by_country(country):
	# Mengambil data universitas berdasarkan "country"
    url = f'http://universities.hipolabs.com/search?country={country}'
    response = requests.get(url)

    # Memeriksa status kode respon
    if response.status_code == 200:
        data = response.json()  # Mengambil data dalam format JSON
    else:
        print(f'Gagal mengambil data untuk negara {country}. Status code: {response.status_code}')
        data = None
    
    return data

# Mendapatkan data universitas di "United States"
country = 'United States'
universities_data = get_universities_by_country(country)

# Membuat dataframe dari data JSON
df = pd.DataFrame(universities_data)

# Filter data yang tidak memiliki "state-province"
df_filtered = df.dropna(subset=['state-province'])

# Menampilkan data hasil filtering
print("DataFrame setelah filtering data yang memiliki state-province:")
print(df_filtered[['name', 'web_pages', 'country', 'domains', 'state-province']].head())
