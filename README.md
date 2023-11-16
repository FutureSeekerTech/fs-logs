<p align="center">
  <img width="240" height="240" src="https://cdn.discordapp.com/attachments/1078837522882367508/1114897951177855059/fstech_logo.png">
</p>

# FS-LOGS

FiveM script logs yang memungkinkan untuk setiap player memiliki logs file sendiri untuk memudahkan melakukan checking logs.
Kategori logs akan dibagi menjadi dua yaitu player logs dan server logs.

## Installation

    1. Download/clone repository ini
    2. Extract/Paste folder repository di folder resource server kalian. Pastikan nama foldernya adalah fs-logs
    3. Pastikan start/ensure fs-logs pada server.cfg setelah core framework kalian
    4. buat folder logs pada server data (folder logs berada pada satu folder yang sama dengan server.cfg/luar dari folder resources)
    5. didalam folder logs buat folder server dan folder player (contoh ada di lampiran gambar)

## Dependency
    1. QBCore

## Pemanggilan Event Dari Client Side
    TriggerServerEvent('fs-logs:server:log', type, category, message)
    type: player/server [string]
    category: diisi bebas [string]
    message: Isi Pesan Logs [string]
    
    Contoh:
    TriggerServerEvent('fs-logs:server:log', 'player', 'jobs', "Mendapatkan 1x Batu dari menambang")

## Pemanggilan Event Dari Server Side
    TriggerEvent('fs-logs:server:log', type, category, message, source)
    type: player/server [string]
    category: diisi bebas [string]
    message: Isi Pesan Logs [string]
    source/key: source pemanggil event/key untuk type server logs (detail bisa dibaca dibagian Catatan)

## Catatan Penting
  Ada sedikit perbedaan untuk cara pemanggilan untuk type logs player dan server
    untuk type logs player argument/parameter ke-4 ketika pemanggilan event diisi dengan source (abaikan jika memanggil event dari client karena source automatis keisi).

  Sedangkan untuk logs type server, argument/parameter ke-4 ketika pemanggilan event diisi dengan key, hal ini agar logs type server terhindar dari spam menggunakan trigger exploit. key default adalah "keyforserverlog". Kalian bisa merubahnya dengan cara merubah semua kode yang mengandung string "keyforserverlog".

  Harap gunakan logs type server hanya dipanggil dari server side karena pada awalnya memang diperuntukkan hanya bisa dipanggil dari server side agar key tidak bocor pada sisi client (Tidak Wajib) Kalian bisa menggunakannya jika dirasa diperlukan (Dari sisi script tidak dilimit hanya bisa dipanggil dari server side saja untuk flexibilitas penggunaan)

## Gambar
![struktur](https://cdn.discordapp.com/attachments/1128226169339265125/1174671843572056146/image.png)
![struktur2](https://cdn.discordapp.com/attachments/1128226169339265125/1174672241745723462/image.png)
![struktur3](https://cdn.discordapp.com/attachments/1128226169339265125/1174672366148784208/image.png)
![example](https://cdn.discordapp.com/attachments/1128226169339265125/1174672595816288326/image.png)
![example2](https://cdn.discordapp.com/attachments/1128226169339265125/1174672826914062346/image.png)
