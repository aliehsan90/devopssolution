import re

# Input file containing names and email addresses
input_file = "names_emails.txt"

# Function to extract and convert email addresses to lowercase using regular expressions
def extract_emails_with_regex(file_path):
    with open(file_path, 'r') as file:
        for line in file:
            emails = re.findall(r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}', line)
            for email in emails:
                print(email.lower())

# Function to extract and convert email addresses to lowercase using string manipulation
def extract_emails_with_split(file_path):
    with open(file_path, 'r') as file:
        for line in file:
            email = line.split()[-1]
            print(email.lower())

print("Using regular expressions:")
extract_emails_with_regex(input_file)

print("\nUsing string manipulation:")
extract_emails_with_split(input_file)

