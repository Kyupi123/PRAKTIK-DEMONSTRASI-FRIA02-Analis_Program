<!DOCTYPE html>
<html lang="en">
<head>
  <title>Praktik Demonstrasi Program Analyst - BNSP</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
  <link rel="stylesheet" href="https://cdn.datatables.net/2.0.2/css/dataTables.dataTables.css"/>
  <script src="https://cdn.datatables.net/2.0.2/js/dataTables.js"></script>
  <script src="initdatatables.js"></script>
</head>

<body class="p-3">
<?php
  require('Navigasi.php');
?>
<div class="card" style="margin-top: 50px;">
<div class="card-header p-3">
    <h2>All tables from FRIA02 database</h2>
</div>
<div class="card-body">
    <div class="container">
    <h3>Jenis Reparasi</h3>
        <table class="table display" id="jenisreparasi">
            <thead class="table-success">
            <tr>
                <th>Kode</th>
                <th>Nama Reparasi</th>
                <th>Tarif</th>
                <th>Keterangan</th>
            </tr>
            </thead>

            <tbody>
                <?php
                require('Koneksi.php');
                $sql = "SELECT kdJenisRep, reparasi, tarif, keterangan FROM jenis_reparasi";
                $query = mysqli_query($koneksi,$sql)
                            or die('SQL error: '. mysqli_error($koneksi));
                while ($row = mysqli_fetch_array($query))
                {
                    $tarif = number_format($row['tarif']);
                    echo "<tr>
                        <td>$row[kdJenisRep]</td>
                        <td>$row[reparasi]</td>
                        <td>Rp. $tarif</td>
                        <td>$row[keterangan]</td>
                        </tr>";
                }
                mysqli_close($koneksi);
                ?>
            </tbody>
        </table>
    </div>

    <div class="container">
    <h3>Reparasi</h3>
        <table class="table display" id="reparasi">
            <thead class="table-success">
            <tr>
                <th>No. Reparasi</th>
                <th>Tanggal Reparasi</th>
                <th>Nama Montir</th>
                <th>No. Mobil</th>
                <th>Jenis Reparasi</th>
                <th>Tanggal Pembayaran</th>
                <th>Status</th>
            </tr>
            </thead>

            <tbody>
                <?php
                require('Koneksi.php');
                $sql = "SELECT noReparasi, tglReparasi, namaMontir, noMobil, kdJenisRep, tglBayar, status FROM reparasi";
                $query = mysqli_query($koneksi,$sql)
                            or die('SQL error: '. mysqli_error($koneksi));
                while ($row = mysqli_fetch_array($query))
                {
                    echo "<tr>
                        <td>$row[noReparasi]</td>
                        <td>$row[tglReparasi]</td>
                        <td>$row[namaMontir]</td>
                        <td>$row[noMobil]</td>
                        <td>$row[kdJenisRep]</td>
                        <td>$row[tglBayar]</td>
                        <td>$row[status]</td>
                        </tr>";
                }
                mysqli_close($koneksi);
                ?>
            </tbody>
        </table>
    </div>

    <div class="container">
    <h3>Detil Reparasi</h3>
        <table class="table display" id="detilrep">
            <thead class="table-success">
            <tr>
                <th>No. Reparasi</th>
                <th>Kode Spartpart</th>
                <th>Jumlah Penggunaan</th>
            </tr>
            </thead>

            <tbody>
                <?php
                require('Koneksi.php');
                $sql = "SELECT noReparasi, kdSparepart, jmlSparepart FROM detil_rep";
                $query = mysqli_query($koneksi,$sql)
                            or die('SQL error: '. mysqli_error($koneksi));
                while ($row = mysqli_fetch_array($query))
                {
                    echo "<tr>
                        <td>$row[noReparasi]</td>
                        <td>$row[kdSparepart]</td>
                        <td>$row[jmlSparepart]</td>
                        </tr>";
                }
                mysqli_close($koneksi);
                ?>
            </tbody>
        </table>
    </div>

    <div class="container">
    <h3>Sparepart</h3>
        <table class="table display" id="sparepart">
            <thead class="table-success">
            <tr>
                <th>Kode Sparepart</th>
                <th>Nama Sparepart</th>
                <th>Harga</th>
                <th>Stok</th>
            </tr>
            </thead>

            <tbody>
                <?php
                require('Koneksi.php');
                $sql = "SELECT kdSparepart, namaSparepart, harga, stok FROM sparepart";
                $query = mysqli_query($koneksi,$sql)
                            or die('SQL error: '. mysqli_error($koneksi));
                while ($row = mysqli_fetch_array($query))
                {
                    $harga = number_format($row['harga']);
                    echo "<tr>
                        <td>$row[kdSparepart]</td>
                        <td>$row[namaSparepart]</td>
                        <td>Rp. $harga</td>
                        <td>$row[stok]</td>
                        </tr>";
                }
                mysqli_close($koneksi);
                ?>
            </tbody>
        </table>
    </div>
</div>
</div>
</body>
</html>