$out_dir = '.build';
$pdf_mode = 1;
# Copy PDF back to source dir after successful compile so click-to-view and outer-git sync still work
$success_cmd = 'cp %D %R.pdf';
