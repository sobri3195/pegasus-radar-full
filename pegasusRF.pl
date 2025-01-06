use strict;
use warnings;
use PDL;
use PDL::NiceSlice;
use PDL::Graphics::Gnuplot qw(gpwin gpset gpclose);

# Parameter radar
my $fc = 10e9;  # Frekuensi carrier (10 GHz)
my $c = 3e8;    # Kecepatan cahaya (m/s)
my $lambda_ = $c / $fc;  # Panjang gelombang
my $T = 1e-6;   # Durasi pulsa (1 mikrodetik)
my $B = 1e6;    # Bandwidth (1 MHz)
my $fs = 2 * $B; # Frekuensi sampling (2 * Bandwidth)
my $t = sequence($T * $fs) / $fs;  # Waktu sampling

# Sinyal yang dipancarkan (chirp signal)
my $f0 = $fc - $B / 2;  # Frekuensi awal
my $f1 = $fc + $B / 2;  # Frekuensi akhir
my $tx_signal = cos(2 * 3.141592653589793 * ($f0 * $t + ($B / (2 * $T)) * $t ** 2));

# Plot sinyal yang dipancarkan
gpwin('Sinyal Radar yang Dipancarkan (Chirp Signal)');
gpset('xlabel', 'Waktu (s)');
gpset('ylabel', 'Amplitudo');
gpset('title', 'Sinyal Radar yang Dipancarkan (Chirp Signal)');
gpset('grid', 'on');
gplot($t, $tx_signal);

# Parameter objek
my $R = 1000;  # Jarak objek (1000 meter)
my $tau = 2 * $R / $c;  # Waktu tunda (time delay)

# Sinyal yang dipantulkan (reflected signal)
my $rx_signal = cos(2 * 3.141592653589793 * ($f0 * ($t - $tau) + ($B / (2 * $T)) * ($t - $tau) ** 2));

# Plot sinyal yang dipantulkan
gpwin('Sinyal Radar yang Dipantulkan');
gpset('xlabel', 'Waktu (s)');
gpset('ylabel', 'Amplitudo');
gpset('title', 'Sinyal Radar yang Dipantulkan');
gpset('grid', 'on');
gplot($t, $rx_signal);

# Matched filtering
my $matched_filter = reverse($tx_signal->complex->conj);
my $output_signal = $rx_signal->convolve($matched_filter);

# Plot hasil matched filtering
gpwin('Hasil Matched Filtering');
gpset('xlabel', 'Waktu (s)');
gpset('ylabel', 'Amplitudo');
gpset('title', 'Hasil Matched Filtering');
gpset('grid', 'on');
gplot($t, $output_signal->abs);

# Deteksi puncak
my $peak_index = which_max($output_signal->abs);
my $peak_time = $t->at($peak_index);
my $detected_range = ($peak_time * $c) / 2;  # Jarak objek

print "Objek terdeteksi pada jarak: " . sprintf("%.2f", $detected_range) . " meter\n";

# Analisis Doppler (Opsional)
# Parameter Doppler
my $v = 10;  # Kecepatan objek (10 m/s)
my $fd = (2 * $v * $fc) / $c;  # Frekuensi Doppler

# Sinyal yang dipantulkan dengan pergeseran Doppler
my $rx_signal_doppler = cos(2 * 3.141592653589793 * (($f0 + $fd) * ($t - $tau) + ($B / (2 * $T)) * ($t - $tau) ** 2));

# Plot sinyal yang dipantulkan dengan pergeseran Doppler
gpwin('Sinyal Radar yang Dipantulkan dengan Pergeseran Doppler');
gpset('xlabel', 'Waktu (s)');
gpset('ylabel', 'Amplitudo');
gpset('title', 'Sinyal Radar yang Dipantulkan dengan Pergeseran Doppler');
gpset('grid', 'on');
gplot($t, $rx_signal_doppler);

# Matched filtering dengan sinyal Doppler
my $matched_filter_doppler = reverse($tx_signal->complex->conj);
my $output_signal_doppler = $rx_signal_doppler->convolve($matched_filter_doppler);

# Plot hasil matched filtering dengan sinyal Doppler
gpwin('Hasil Matched Filtering dengan Pergeseran Doppler');
gpset('xlabel', 'Waktu (s)');
gpset('ylabel', 'Amplitudo');
gpset('title', 'Hasil Matched Filtering dengan Pergeseran Doppler');
gpset('grid', 'on');
gplot($t, $output_signal_doppler->abs);

# Deteksi puncak dengan sinyal Doppler
my $peak_index_doppler = which_max($output_signal_doppler->abs);
my $peak_time_doppler = $t->at($peak_index_doppler);
my $detected_range_doppler = ($peak_time_doppler * $c) / 2;  # Jarak objek

print "Objek terdeteksi pada jarak: " . sprintf("%.2f", $detected_range_doppler) . " meter\n";

# Hitung kecepatan objek dari pergeseran Doppler
my $detected_fd = ($peak_time_doppler - $peak_time) * $fc / $tau;
my $detected_v = ($detected_fd * $c) / (2 * $fc);

print "Kecepatan objek: " . sprintf("%.2f", $detected_v) . " m/s\n";

gpclose();
