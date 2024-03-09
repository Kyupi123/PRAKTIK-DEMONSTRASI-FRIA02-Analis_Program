SELECT re.noReparasi, re.namaMontir, jr.reparasi, sp.namaSparepart, sp.stok 
FROM reparasi re JOIN jenis_reparasi jr USING (kdJenisRep)
JOIN detil_rep dr USING (noReparasi)
JOIN sparepart sp ON dr.kdSparepart=sp.kdSparepart;