$out_dir = '.build';
$pdf_mode = 1;
# Copy back ONLY the PDF of the document just built; never glob-copy every .build/*.pdf,
# which re-timestamps unchanged PDFs of other documents and makes iCloud re-sync them.
# Paths quoted because the Mac iCloud path contains spaces.
$success_cmd = q{cp "%D" "./%R.pdf"};
