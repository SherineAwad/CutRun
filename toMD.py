import os

# Path where your .txt files are stored
input_folder = '/nfs/turbo/umms-thahoang/sherine/mouseCutRun/'  # Replace with your folder path

# List all the .txt files in the directory
txt_files = [f for f in os.listdir(input_folder) if f.endswith('_stats.txt')]

# Output .md file name
output_md_file = 'flagstats.md'

# Open the output .md file in write mode
with open(output_md_file, 'w') as md_file:
    # Write a title for the Markdown file
    md_file.write("# Sample Statistics\n\n")
    
    # Loop through each txt file and convert to markdown format
    for txt_file in txt_files:
        # Write a header for each sample
        md_file.write(f"## {txt_file.replace('.txt', '')} Statistics\n\n")
        
        # Open the .txt file and read its content
        with open(os.path.join(input_folder, txt_file), 'r') as file:
            content = file.read()
        
        # Write the content into the markdown file
        md_file.write(f"```\n{content}\n```\n\n")

print(f"Successfully created {output_md_file}")

