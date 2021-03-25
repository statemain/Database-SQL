USE rs_invoice;

SHOW TABLES;

-- Membuat Table & Primary Key dengan Constraint
CREATE TABLE tbl_transaksi2 (
  id_transaksi INT(11) NOT NULL AUTO_INCREMENT,
  no_invoice VARCHAR(60) NOT NULL,
  no_po VARCHAR(60) NOT NULL,
  kode_partner VARCHAR(60) NOT NULL,
  kode_produk VARCHAR(60) NOT NULL,
  dateadded TIMESTAMP,
  jml_qty INT(11),
  CONSTRAINT pk_transaksi2 PRIMARY KEY (id_transaksi, no_invoice, no_po, kode_partner, kode_produk)
);

-- Membuat Table dan Primary key Langsung
CREATE TABLE tbl_manager2 (
    kode_manager VARCHAR(60) PRIMARY KEY,
    posisi TEXT
);

-- Membuat Table dan Primiary Key dengan Alter Table 
CREATE TABLE tbl_invoice2 (
    no_invoice VARCHAR(60) NOT NULL,
    tangal_dibuat DATETIME,
    mata_uang TEXT,
    ppn INT(11),
    biayakirim INT(11),
    kode_bank VARCHAR(60) NOT NULL,
    no_suratjalan VARCHAR(60) NOT NULL,
    kode_manager VARCHAR(60) NOT NULL,
    tgl_jatuhtempo DATETIME,
    no_staff VARCHAR(60) NOT NULL
);

ALTER TABLE tbl_invoice2
ADD CONSTRAINT pk_invoice2
PRIMARY KEY (no_invoice, kode_bank, no_suratjalan, kode_manager, no_staff);

DESC tbl_invoice2;

SHOW TABLES;

-- RELASI TABLE 
-- RELASI TABLE invoice KE TABLE rekening perusahaan
ALTER TABLE tbl_invoice
ADD CONSTRAINT fk_invoice2rekeningperusahaan
FOREIGN KEY (kode_bank) REFERENCES tbl_rek_perusahaan (kode_bank); 

-- RELASI TABLE invoice KE TABLE surat jalan
ALTER TABLE tbl_invoice
ADD CONSTRAINT fk_invoice2suratjalan
FOREIGN KEY (no_suratjalan) REFERENCES tbl_suratjalan (no_suratjalan); 

-- RELASI TABLE invoice KE TABLE manager
ALTER TABLE tbl_invoice
ADD CONSTRAINT fk_invoice2manager
FOREIGN KEY (kode_manager) REFERENCES tbl_manager (kode_manager); 

-- RELASI TABLE transaksi KE TABLE invoice
ALTER TABLE tbl_transaksi
ADD CONSTRAINT fk_transaksi2invoice
FOREIGN KEY (no_invoice) REFERENCES tbl_invoice (no_invoice); 

-- RELASI TABLE transaksi KE TABLE po
ALTER TABLE tbl_transaksi
ADD CONSTRAINT fk_transaksi2po
FOREIGN KEY (no_po) REFERENCES tbl_po (no_po); 

-- RELASI TABLE transaksi KE TABLE staff
ALTER TABLE tbl_transaksi
ADD CONSTRAINT fk_transaksi2staff
FOREIGN KEY (no_staff) REFERENCES tbl_staff (no_staff); 

-- RELASI TABLE transaksi KE TABLE partner
ALTER TABLE tbl_transaksi
ADD CONSTRAINT fk_transaksi2partner 
FOREIGN KEY (kode_partner) REFERENCES tbl_partner (kode_partner); 

-- RELASI TABLE transaksi KE TABLE produk
ALTER TABLE tbl_transaksi
ADD CONSTRAINT fk_transaksi2produk 
FOREIGN KEY (kode_produk) REFERENCES tbl_produk (kode_produk); 