import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import sys

# Check for correct usage
if len(sys.argv) != 3:
    print("Usage: python plot_peak_sizes.py <peaks.narrowPeak> <output_plot.png>")
    sys.exit(1)

# Read arguments
peak_file = sys.argv[1]
output_file = sys.argv[2]

# MACS2 narrowPeak format has 10 columns: chrom, start, end, name, score, strand, signal, pval, qval, summit
columns = [
    "chrom", "start", "end", "name", "score",
    "strand", "signal", "pval", "qval", "summit"
]

# Read the narrowPeak file
df = pd.read_csv(peak_file, sep="\t", header=None, names=columns)

# Compute peak size
df["peak_size"] = df["end"] - df["start"]

# Optional: Filter out extremely large peaks (>5000 bp) to avoid skewed histograms
filtered_df = df[df["peak_size"] < 5000]

# Plot histogram
plt.figure(figsize=(8, 5))
sns.histplot(filtered_df["peak_size"], bins=50, kde=False, color="skyblue", edgecolor="black")
plt.title("Peak Size Distribution")
plt.xlabel("Peak Size (bp)")
plt.ylabel("Frequency")
plt.xlim(0, 5000)  # Adjust if needed based on your data
plt.tight_layout()

# Save plot
plt.savefig(output_file, dpi=300)
plt.close()

print(f"Histogram saved to {output_file}")

