# Import librari yang diperlukan
import glob
import pandas as pd

# List CSV file dalam direktori
directory = '/path/to/csv_folder/'
csv_files = glob.glob(directory + '*.csv')

# Inisialisasi list kosong untuk menyimpan DataFrame dari setiap file
dfs = []

# Membaca setiap file CSV
for filename in csv_files:
    df = pd.read_csv(filename)
    dfs.append(df)

# Menggabungkan file CSV dalam satu dataframe
combined_df = pd.concat(dfs, ignore_index=True)

# Menghapus baris yang memiliki nila NaN
df = combined_df.dropna()

# Mengubah format kolom 'date' menjadi datetime 
df['date'] = pd.to_datetime(df['date'])

# Sorting data terbaru berdasarkan kolom 'date' dan menghapus data duplikat berdasarkan 'transaction_id'
df = df.sort_values(by='date', ascending=False).drop_duplicates(subset='transaction_id')

# Menghitung total penjualan (jumlah x harga) dan dikelompokkan berdasarkan branch
df['total'] = df['quantity'] * df['price']
total_sales = df.groupby('branch')['total'].sum().reset_index()
total_sales.to_csv('total_sales_per_branch.csv', index=False, columns=['branch', 'total'])
