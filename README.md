
# Wisata Jawa Barat
<p align="center">
  <img width="900" height="500" src="https://github.com/fidafarihaa/kelompok8_MDS/blob/main/image/Header.png">
</p>

## :classical_building: Menu

- [Welcome](#bestcampy-welcome)
- [Deskripsi](#diya_lamp-deskripsi)
- [Requirements](#page_with_curl-requirements)
- [Screenshot](#clapper-screenshot)
- [Demo](#film_projector-demo)
- [Skema](#atom-skema)
- [ERD](#books-erd)
- [Data Description](#open_book-deskripsi-data)
- [Folder Structure](#file_folder-struktur-folder)
- [Our Team](#owl-tim-pengembang)


## :bestcampy: Welcome

Selamat Datang di platform Wisata Jawa Barat. Disini, anda dapat menemukan berbagai destinasi wisata yang indah, menarik, dan menambah khazanah pengetahuan anda. Terdapat 6 jenis destinasi yang kami sajikan, yaitu:
a. Pantai
b. Wisata Air
c. Wisata Alam
d. Wisata Edukasi
e. Wisata Keagamaan
f. Wisata Sejarah

## :diya_lamp: Deskripsi

Jawa Barat merupakan salah satu provinsi yang terletak di pulau Jawa. Jawa Barat memiliki banyak sekali tempat wisata yang dapat kalian kunjungi, tentunya tidak hanya wisata yang ada di Kota Bandung saja, di kabupaten-kabupaten lain juga banyak sekali lokasi wisata yang indah. Pada project akhir mata kuliah Manajemen Data Statistika kali ini, kelompok kami akan merangkum lokasi wisata yang ada di provinsi Jawa Barat.

## :page_with_curl: Requirements

- Scrapping data menggunakan package R yaitu `rvest` dengan pendukung package lainnya seperti `tidyverse`,`rio`,`kableExtra` dan `stingr`  
- RDBMS yang digunakan adalah PostgreSQL dan ElephantSQL
- Dashboard menggunakan `shinny`, `shinnythemes`, `bs4Dash`, `DT`, dan `dplyr` dari package R

## :clapper: Screenshot
Berikut untuk tampilan depan dari dashboard wisata jawa barat
<p div align="center">
  <img width="700" height="450" src="https://github.com/fidafarihaa/kelompok8_MDS/blob/main/image/Tampilan Depan.jpg">
</p>

## :film_projector: Demo

Berikut link untuk shinnyapps atau dashboard dari project kami: 
https://mdskelompok8.shinyapps.io/pariwisata/

## :atom: Skema
Project ini dirancang dengan skema sebagai berikut:
<p div align="center">
  <img width="700" height="450" src="https://github.com/fidafarihaa/kelompok8_MDS/blob/main/image/SKEMA.png">
</p>

## :books: ERD
ERD (Entity Relationship Diagram) menampilkan hubungan antara entitas dengan atribut. Pada project ini, terdapat 4 entitas, yaitu entitas kabkot, kecamatan, kelurahan serta wisata. Pada entitas kabkot terdapat kode_kabkot yang akan terhubung ke entitas kecamatan, selanjutnya pada entitas kecamatan terdapat atribut kode_kec yang akan terhubung dengan entitas kelurahan, serta pada entitas kelurahan terdapat kode_kel yang akan terhubung dengan entitas wisata.

<p align="center">
  <img width="600" height="400" src="https://github.com/fidafarihaa/kelompok8_MDS/blob/main/image/ERD.png">
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
	kode_kec character(8) COLLATE pg_catalog."default" NOT NULL,
    kode_kabkot character(6) COLLATE pg_catalog."default" NOT NULL,
    nama_kec character varying(20) COLLATE pg_catalog."default" NOT NULL,
    jml_pddk_kec integer NOT NULL,
    CONSTRAINT kecamatan_pkey PRIMARY KEY (kode_kec),
    CONSTRAINT Kecamatan_Kode_Kabkot_fkey FOREIGN KEY (kode_kabkot)
        REFERENCES public.kabkot (kode_kabkot) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
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
	kode_kel character(13) COLLATE pg_catalog."default" NOT NULL,
    kode_kec character(8) COLLATE pg_catalog."default" NOT NULL,
    nama_kel character varying(20) COLLATE pg_catalog."default" NOT NULL,
    jml_pddk_kel integer NOT NULL,
    CONSTRAINT kecamatan_pkey PRIMARY KEY (kode_kel),
    CONSTRAINT Kelurahan_kode_kec_fkey FOREIGN KEY (kode_kec)
        REFERENCES public.Kecamatan (kode_kec) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
);
```

### Create Table Wisata
Table wisata berisi data wisata yang terdapat di Provinsi Jawa Barat, selain itu tabel ini menyajikan lokasi wisata tersebut, deskripsi serta termasuk kedalam tipe apakah wisata tersebut serta berapa biaya masuk lokasi wisata tersebut. Dengan adanya ini dapat memudahkan dalam memilih lokasi wisata jika berkunjung ke Provinsi Jawa Barat.
| Attribute                  | Type                   | Description                         |
|:---------------------------|:-----------------------|:------------------------------------|
| Kode_Wisata                | character (7) 	      | Kode Wisata                         |
| Tipe_Wisata                | character varying(50)  | Tipe Wisata                         |
| Nama_Wisata                | character varying(50)  | Nama Wisata                         |	
| Kode_Kabkot                | character (6)          | Kode Kabupaten Kota                 |
| Kode_Kec                   | character (8)	      | Kode Kecamatan                      |
| Kode_Kel    	     	     | character (13)	      | Kode Kelurahan                      |
| Deskripsi                  | character varying(1000)| Deskripsi Wisata     		    |
| Harga_Tiket		     | character varying(50)  | Harga Tiket Masuk Wisata	    |
| Rating		     | character varying(20)  | Rating Wisata	 		    |
| Alamat		     | character varying(50)  | Alamat Lengkap Wisata		    |

dengan script SQL sebagai berikut:              
```sql
CREATE TABLE IF NOT EXISTS public.Wisata (
    Kode_Wisata character(7) COLLATE pg_catalog."default" NOT NULL,
    Tipe_Wisata varchar(50) COLLATE pg_catalog."default" NOT NULL,
    Nama_Wisata varchar(50) COLLATE pg_catalog."default" NOT NULL, 
    Kode_Kabkot character(6) COLLATE pg_catalog."default" NOT NULL,  
    Kode_Kec character(8) NOT NULL,
    Kode_Kel character(13) NOT NULL,
    Deskripsi varchar(1000) NOT NULL,
    Harga_Tiket varchar (50) NOT NULL,  
    Rating varchar (20) NOT NULL,
    Alamat varchar (50) NOT NULL,
    CONSTRAINT Wisata_pkey PRIMARY KEY (Kode_Wisata),
    CONSTRAINT Wisata_Kode_Kabkot_fkey FOREIGN KEY (Kode_Kabkot)
        REFERENCES public.kabkot (Kode_Kabkot) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT Wisata_Kode_kec_fkey FOREIGN KEY (Kode_kec)
        REFERENCES public.kecamatan (Kode_kec) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT Wisata_Kode_Kel_fkey FOREIGN KEY (Kode_Kel)
        REFERENCES public.kelurahan (Kode_Kel) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    );
```

## :file_folder: Folder Structure

```
.
├── Image
├── app           # ShinyApps
│   ├── css
│   │   ├── **/*.css
│   ├── server.R
│   └── ui.R
├── data 
│   ├── csv
│   │   ├── **/*.css
│   └── sql
|       └── db.sql
└── README.md
```

## :owl: Our Team

Kelompok 8

- Backend Developer: [Aleytha Ilahnugrah Kurnadipare](https://github.com/aleythailahnugrah) (G1501231067)
 

- Database Manager: [Fida Fariha Amatullah](https://github.com/fidafarihaa) (G1501231064)


- Frontend Developer: [Billy](https://github.com/billyawan) (G1501231034)


- Technical Writer: [Asri Pratiwi](https://github.com/asripratiwi) (G1501231014)

