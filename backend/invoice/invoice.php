<?php

    include '../config/connection.php';

    if($_SERVER['REQUEST_METHOD'] == 'POST') {
        $noinvoice = $_POST['no_invoice'];

        $cekdatainvoice = mysqli_query($_AUTH, "SELECT COUNT(*) 'totaldata' FROM tbl_invoice WHERE no_invoice = '$noinvoice';");
        $ketersediaaninvoice = mysqli_fetch_assoc($cekdatainvoice);

        if ($ketersediaaninvoice['totaldata'] == 0) {
            $response["message"] = trim("Sory!, Data invoice dengan nomor " . $noinvoice . " TIDAK terdaftar di database, mohon cek kembali nomor invoice yang anda cari");
            $response["code"] = 404;
            $response["status"] = false;

            echo json_encode($response);
        } else {

            $headerinvoice = mysqli_query($_AUTH, "SELECT tbl_invoice.no_invoice, tbl_invoice.tanggal_dibuat, tbl_invoice.mata_uang, tbl_po.no_po, tbl_po.tanggal_po, tbl_invoice.tgl_jatuhtempo, tbl_staff.no_staff, tbl_staff.nama_staff, tbl_staff.posisi FROM tbl_transaksi JOIN tbl_invoice ON tbl_invoice.no_invoice=tbl_transaksi.no_invoice JOIN tbl_po ON tbl_po.no_po=tbl_transaksi.no_po JOIN tbl_staff ON tbl_staff.no_staff=tbl_transaksi.no_staff WHERE tbl_transaksi.no_invoice = '$noinvoice'");
            $extract_header = mysqli_fetch_assoc($headerinvoice);

            $response = array();

            $response["message"] = trim("Data invoice berhasil di load");
            $response["code"] = 200;
            $response["status"] = true;
            $response["totaldata"] = ROUND($ketersediaaninvoice['totaldata']);
            $response["header_invoice"] = 
                                        [ 
                                            "no_invoice" => $extract_header['no_invoice'],
                                            "tanggal_buat" => $extract_header['tanggal_dibuat'], 
                                            "mata_uang" => $extract_header['mata_uang'], 
                                            "no_purchaseorder" => $extract_header['no_po'], 
                                            "tgl_po" => $extract_header['tanggal_po'], 
                                            "no_staff" => $extract_header['no_staff'], 
                                            "staff_bertugas" => $extract_header['nama_staff'], 
                                            "posisi" => $extract_header['posisi']
                                        ];

            $data_partner = mysqli_query($_AUTH, "SELECT tbl_partner.kode_partner, tbl_partner.nama_partner, tbl_partner.alamat_partner, CONCAT(tbl_partner.kota, ' - ', tbl_partner.kode_pos) 'kodepos_kota' FROM tbl_transaksi JOIN tbl_partner ON tbl_partner.kode_partner=tbl_transaksi.kode_partner WHERE tbl_transaksi.no_invoice = '$noinvoice'");
            $extract_partner = mysqli_fetch_assoc($data_partner);

            $response["data_partner"] = 
                                        [ 
                                            "order_dari" => $extract_partner['nama_partner'],
                                            "alamat_perusahaan" => $extract_partner['alamat_partner'],
                                            "kodepos_kota" => $extract_partner['kodepos_kota']
                                        ];

            $listpo_produk = mysqli_query($_AUTH, "SELECT tbl_produk.kode_produk, tbl_produk.produk, tbl_produk.diskon, tbl_produk.minimum_request, tbl_produk.harga_satuan, tbl_produk.satuan, tbl_transaksi.jml_qty 'jml_order', tbl_produk.harga_satuan*tbl_transaksi.jml_qty 'jumlah_rupiah', IF(tbl_transaksi.jml_qty>=tbl_produk.minimum_request, 'Diskon', 'Tidak Diskon') 'keterangan', IF(tbl_transaksi.jml_qty>=tbl_produk.minimum_request, ROUND((tbl_produk.harga_satuan*tbl_transaksi.jml_qty)*tbl_produk.diskon/100, 0), 0) 'potongan_rupiah', tbl_produk.harga_satuan*tbl_transaksi.jml_qty - IF(tbl_transaksi.jml_qty>=tbl_produk.minimum_request, ROUND((tbl_produk.harga_satuan*tbl_transaksi.jml_qty)*tbl_produk.diskon/100, 0), 0) 'total_harga' FROM tbl_transaksi JOIN tbl_produk ON tbl_produk.kode_produk=tbl_transaksi.kode_produk WHERE tbl_transaksi.no_invoice = '$noinvoice'");

            $response["datapo_listproduct"] = array();

            while($row = mysqli_fetch_array($listpo_produk)) {
                $datapo_listproduk = array();

                $data['kode_produk'] = $row['kode_produk'];
                $data['produk'] = $row['produk'];
                $data['harga_satuan'] = ROUND($row['harga_satuan']);
                $data['satuan'] = $row['satuan'];
                $data['jml_order'] = ROUND($row['jml_order']);
                $data['jumlah_rupiah'] = ROUND($row['jumlah_rupiah']);
                $data['keterangan'] = $row['keterangan'];
                $data['potongan_rupiah'] = ROUND($row['potongan_rupiah']);
                $data['total_harga'] = ROUND($row['total_harga']);
                
                array_push($response['datapo_listproduct'], $data);
            }

            $sub_totalpo = mysqli_query($_AUTH, "SELECT SUM(tbl_produk.harga_satuan*tbl_transaksi.jml_qty - IF(tbl_transaksi.jml_qty>=tbl_produk.minimum_request, ROUND((tbl_produk.harga_satuan*tbl_transaksi.jml_qty)*tbl_produk.diskon/100, 0), 0)) 'sub_total' FROM tbl_transaksi JOIN tbl_produk ON tbl_produk.kode_produk=tbl_transaksi.kode_produk JOIN tbl_invoice ON tbl_invoice.no_invoice=tbl_transaksi.no_invoice WHERE tbl_transaksi.no_invoice = '$noinvoice'");

            $extract_subtotalpo = mysqli_fetch_assoc($sub_totalpo);

            $sub_total = $extract_subtotalpo['sub_total'];

            // Pajak Disesuaikan dengan Minimum dari Sub Total
            // Potongan Pajak juga disesuaikan
            switch ($sub_total) {
                case 25000000: 
                    $potong_pajak = 25 / 100 * $sub_total;
                    $ongkir = 3 / 100 * $potong_pajak;
                    break;
                    case 30000000: 
                        $potong_pajak = 30 / 100 * $sub_total;
                        $ongkir = 6 / 100 * $potong_pajak;
                        break;
                        case 35000000: 
                            $potong_pajak = 35 / 100 * $sub_total;
                            $ongkir = 9 / 100 * $potong_pajak;
                            break;
                            case 40000000: 
                                $potong_pajak = 40 / 100 * $sub_total;
                                $ongkir = 12 / 100 * $potong_pajak;
                                break;
                                case 45000000: 
                                    $potong_pajak = 45 / 100 * $sub_total;
                                    $ongkir = 15 / 100 * $potong_pajak;
                                    break;
                                    case 50000000: 
                                        $potong_pajak = 50 / 100 * $sub_total;
                                        $ongkir = 18 / 100 * $potong_pajak;
                                        break;
                                        default: 
                                                $potong_pajak = 10 / 100 * $sub_total;
                                                $ongkir = 5 / 100 * $potong_pajak;
                                                break;
            }

            $response["finalbill"] = [
                                        "sub_totalorder" => ROUND($sub_total),
                                        "potong_pjk" => ROUND($potong_pajak),
                                        "biaya_pengiriman" => ROUND($ongkir),
                                        "total_bayar" => ROUND($sub_total - $potong_pajak + $ongkir)
                                    ];

            echo json_encode($response);
        }

    } else {
        // Request POST belum terpenuhi
        $response["message"] = trim("Oops! Sory, Request API ini membutuhkan parameter!.");
        $response["code"] = 400;
        $response["status"] = false;

        echo json_encode($response);
    }
?>