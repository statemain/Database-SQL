USE rs_invoice;

-- JOIN TABLE MENCARI / TRACKING DATA PRODUK & PARTNER
SELECT tbl_transaksi.id_transaksi, tbl_transaksi.no_invoice, tbl_transaksi.no_po, tbl_produk.kode_produk, tbl_produk.produk, tbl_partner.kode_partner, tbl_partner.nama_partner, tbl_transaksi.dateadded, tbl_transaksi.jml_qty 
FROM tbl_transaksi 
JOIN tbl_partner ON tbl_partner.kode_partner=tbl_transaksi.kode_partner 
JOIN tbl_produk ON tbl_produk.kode_produk=tbl_transaksi.kode_produk;    

-- OPERASI PERKALIAN MENCARI SUB TOTAL
SELECT tbl_transaksi.id_transaksi, tbl_transaksi.no_invoice, tbl_transaksi.no_po, tbl_produk.kode_produk, tbl_produk.produk, tbl_produk.harga_satuan, tbl_partner.kode_partner, tbl_partner.nama_partner, tbl_transaksi.dateadded, tbl_transaksi.jml_qty, tbl_produk.harga_satuan * tbl_transaksi.jml_qty AS sub_total 
FROM tbl_transaksi 
JOIN tbl_partner ON tbl_partner.kode_partner=tbl_transaksi.kode_partner 
JOIN tbl_produk ON tbl_produk.kode_produk=tbl_transaksi.kode_produk

-- FILTER DATA BERDASARKAN NO INVOICE
SELECT tbl_transaksi.id_transaksi, tbl_transaksi.no_invoice, tbl_transaksi.no_po, tbl_produk.kode_produk, tbl_produk.produk, tbl_produk.harga_satuan, tbl_partner.kode_partner, tbl_partner.nama_partner, tbl_transaksi.dateadded, tbl_transaksi.jml_qty, tbl_produk.harga_satuan * tbl_transaksi.jml_qty AS sub_total 
FROM tbl_transaksi 
JOIN tbl_partner ON tbl_partner.kode_partner=tbl_transaksi.kode_partner 
JOIN tbl_produk ON tbl_produk.kode_produk=tbl_transaksi.kode_produk 
WHERE tbl_transaksi.no_invoice = 'FT/30/01/2021'

-- MENAMPILKAN TOTAL HARGA DARI PO BERDASARKAN NO INVOICE
SELECT SUM(tbl_produk.harga_satuan * tbl_transaksi.jml_qty) AS total_harga  
FROM tbl_transaksi 
JOIN tbl_partner ON tbl_partner.kode_partner=tbl_transaksi.kode_partner 
JOIN tbl_produk ON tbl_produk.kode_produk=tbl_transaksi.kode_produk 
WHERE tbl_transaksi.no_invoice = 'FT/30/01/2021'