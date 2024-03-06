# kelompok8_MDS
### Asri Pratiwi (G1501231014)
### Billy (G1501231034)
### Fida Fariha Amatullah (G1501231064)
### Aleytha Ilahnugrah Kurnadipare (G15012310067)

# Wisata Jawa Barat
<p align="center">
  <img width="500" height="200" src="https://upload.wikimedia.org/wikipedia/commons/9/99/Coat_of_arms_of_West_Java.svg">
</p>

## :scroll: Deskripsi

Jawa Barat merupakan salah satu provinsi yang terletak di pulau Jawa. Jawa Barat memiliki banyak sekali tempat wisata yang dapat kalian kunjungi, tentunya tidak hanya wisata yang ada di Kota Bandung saja, di kabupaten-kabupaten lain juga banyak sekali lokasi wisata yang indah. Pada project akhir mata kuliah Manajemen Data Statistika kali ini, kelompok kami akan merangkum lokasi wisata yang ada di provinsi Jawa Barat.

## :bookmark_tabs: Requirements

- Scrapping data menggunakan package R yaitu `rvest` dengan pendukung package lainnya seperti `tidyverse`,`rio`,`kableExtra` dan `stingr`  
- RDBMS yang digunakan adalah PostgreSQL dan ElephantSQL
- Dashboard menggunakan `shinny`, `shinnythemes`, `bs4Dash`, `DT`, dan `dplyr` dari package R

## :question: Skema
Project ini dirancang dengan skema sebagai berikut:
<p div align="center">
  <img width="700" height="450" src="https://github.com/fidafarihaa/kelompok8_MDS/blob/main/SKEMA.png">
</p>

## :green_book: ERD
ERD (Entity Relationship Diagram) menampilkan hubungan antara entitas dengan atribut. Pada project ini, terdapat 4 entitas, yaitu entitas kabkot, kecamatan, kelurahan serta wisata. Pada entitas kabkot terdapat kode_kabkot yang akan terhubung ke entitas kecamatan, selanjutnya pada entitas kecamatan terdapat atribut kode_kec yang akan terhubung dengan entitas kelurahan, serta pada entitas kelurahan terdapat kode_kel yang akan terhubung dengan entitas wisata.

<p align="center">
  <img width="600" height="400" src="https://github.com/fidafarihaa/kelompok8_MDS/blob/main/ERD.png">
</p>

## :open_book: Deskripsi Data

Berisi tentang tabel-tabel yang digunakan berikut dengan sintaks SQL DDL (CREATE).

### Create Database
Databse Wisata Jabar menyimpan informasi wisata yang ada di provinsi Jawa Barat pada setiap Kabupaten Kota.
```sql
CREATE DATABASE "WisataJabar"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_Indonesia.1252'
    LC_CTYPE = 'English_Indonesia.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
```
### Create Table Kabkot
Table Kabkot memberikan informasi mengenai data Kabupaten dan Kota di Provinsi Jawa Barat, beserta Ibukota setiap Kabupaten Kota dan Jumlah Penduduk di Kabupaten Kota tersebut.
| Attribute          | Type                  | Description                     |
|:-------------------|:----------------------|:--------------------------------|
| Kode_Kabkot        | character (6) 	     | Kode Kabupaten Kota             |
| Nama_Kabkot        | character varying(20) | Nama Kabupaten Kota             |
| Ibukota            | character varying(20) | Ibukota Kabupaten Kota          |
| Jml_pddk           | smallint 	     | Jumlah Penduduk                 |

dengan script SQL sebagai berikut:
```sql
CREATE TABLE IF NOT EXISTS public.KabKot (
    Kode_Kabkot character(6) NOT NULL,
	Nama_Kabkot varchar(20) NOT NULL,
    Ibukota varchar(20) NOT NULL,
    Jml_pddk int NOT NULL,
    PRIMARY KEY (Kode_Kabkot)
);
```

### Create Table Kecamatan
Table Kecamatan berisi data-data kecamatan di setiap Kabupaten Kota serta jumlah penduduk di setiap Kecamatan tersebut.
| Attribute          | Type                  | Description                     |
|:-------------------|:----------------------|:--------------------------------|
| Kode_Kec           | character (8) 	     | Kode Kecamatan                  |
| Kode_Kabkot        | character (6)	     | Kode Kabupaten Kota             |
| Nama_Kec           | character varying(20) | Nama Kecamatan        	       |
| Jml_pddk_kec       | smallint 	     | Jumlah Penduduk Kecamatan       |

dengan script SQL sebagai berikut:
```sql
CREATE TABLE IF NOT EXISTS public.Kecamatan (
    Kode_Kec character(8) NOT NULL,
	Kode_Kabkot character(6) NOT NULL,
	Nama_Kec varchar(20) NOT NULL,
    Jml_pddk_kec int NOT NULL,
    PRIMARY KEY (Kode_Kec)
);
```

### Create Table Kelurahan
Table Kelurahan berisi data-data kelurahan di setiap Kecamatan serta jumlah penduduk di setiap kelurahan. Note: Beberapa kelurahan memiliki data jumlah penduduk yang tidak sesuai dengan data Indonesia, karena data dibuat sendiri.
| Attribute          | Type                  | Description                     |
|:-------------------|:----------------------|:--------------------------------|
| Kode_Kel           | character (13) 	     | Kode Kelurahan                  |
| Kode_Kec           | character (8)	     | Kode Kecamatan                  |
| Nama_Kel           | character varying(20) | Nama Kelurahan                  |
| Jml_pddk_kel       | smallint 	     | Jumlah Penduduk Kelurahan       |

dengan script SQL sebagai berikut:
```sql
CREATE TABLE IF NOT EXISTS public.Kelurahan (
    Kode_Kel character(13) NOT NULL,
	Kode_Kec character(8) NOT NULL,
	Nama_Kel varchar(20) NOT NULL,
    Jml_pddk_kel int NOT NULL,
    PRIMARY KEY (Kode_Kel)
);
