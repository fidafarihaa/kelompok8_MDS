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
  <img width="700" height="350" src="https://github.com/fidafarihaa/kelompok8_MDS/blob/main/SKEMA.png">
</p>

## :green_book: ERD
ERD (Entity Relationship Diagram) menampilkan hubungan antara entitas dengan atribut. Pada project ini, terdapat 4 entitas, yaitu entitas kabkot, kecamatan, kelurahan serta wisata. Pada entitas kabkot terdapat kode_kabkot yang akan terhubung ke entitas kecamatan, selanjutnya pada entitas kecamatan terdapat atribut kode_kec yang akan terhubung dengan entitas kelurahan, serta pada entitas kelurahan terdapat kode_kel yang akan terhubung dengan entitas wisata.

<p align="center">
  <img width="600" height="400" src="https://github.com/fidafarihaa/kelompok8_MDS/blob/main/ERD.jpeg?raw=true">
</p>
