##############################################################################################################
# Author   : Freeman
# email    : flo@radford.edu
# Date     : 2025.03.25
# desc     : Pull the 7z archive ruby package to your Pc and extract it to your home location
# comments : You can certainly alter this code to get the devkit executable binary version with an installer.
# binary   : https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.3.6-2/rubyinstaller-devkit-3.3.6-2-x64.exe
##############################################################################################################
import sys, os, re
import shutil, hashlib

home_dir = os.path.expanduser('~')

try:
    import py7zr
except ImportError as e:
    print("Need to install py7zr !")
    sys.exit(0)

try:
    from bs4 import BeautifulSoup
except ImportError as e:
    print("Need to install bs4 !")
    sys.exit(0)

try: 
    from tqdm import tqdm
except ImportError as e:
    print("Need to install tqdm")
    sys.exit(0)

try:
    import requests
except ImportError as e:
    print("Need to install requests !")
    sys.exit(0)

def getSHA256(fp):
    sha256_hash = hashlib.sha1()
    try:
        with open(fp, 'rb') as file:
            while True:
                chunk = file.read(4096)
                if not chunk:
                    break
                sha256_hash.update(chunk)
        return sha256_hash.hexdigest()
    except FileNotFoundError:
        return "File not found."
    except Exception as e:
        return f"An error occurred: {e}"

def checkForRuby():
    if os.path.exists(home_dir + "\\" + "ruby"):
        print("\n  Found Ruby installation .....")
        print("\n  Removing existing Ruby installation in user home directory.")
        shutil.rmtree(home_dir + "\\" + "ruby")

    print("\n")
    print("##########################################################")
    print("Install the latest version of Ruby Programming Lanaguage  ")
    print("##########################################################")   
    print()
    
    ruby_archive = []
    website = "https://rubyinstaller.org/downloads/index.html"
    ws = requests.get(website)

    if ws.status_code != 200:
        print("\n")
        print("######################################")
        print("Ruby Windows Website is not available.")
        print("######################################")
        print()
        sys.exit()

    soup = BeautifulSoup( ws.content , 'html.parser') 
    for i in soup.find_all('a'):
        abc = str(i.get('href'))
        if abc.endswith(".7z"):
            ruby_archive.append(abc)
    # 0: arm, 1: 86_64, 2: 32bit perhaps
    return ruby_archive[1]    

def downloadRuby(ruby_url):
    # ruby added arm for windows so its the next one
    #ruby_url = ruby_archive[1]
    ruby_file = ruby_url.split('/')[-1]
    ruby_folder = ruby_file.rsplit('.',1)[0]
    resp = requests.get(ruby_url, stream=True)
    file_location = home_dir + "\\" + ruby_file

    # Sizes in bytes.
    total_size = int(resp.headers.get("content-length", 0))
    block_size = 1024

    print("\n")
    print("#######################")
    print("Parsing html file      ")
    print("#######################")
    print("\n")

    # download bar and write to FS
    if resp.status_code == 200:
        with tqdm(total=total_size, unit="B", unit_scale=True) as prog_bar:
            with open(file_location, "wb") as f:
                for data in resp.iter_content(block_size):
                    prog_bar.update(len(data))
                    f.write(data)
                print(f"\n\nFile downloaded successfully: {file_location}\n\n")
    else:
        print(f"\n\nFailed to download file. Status code: {resp.status_code}")
        sys.exit(0)

    return file_location,ruby_folder

def checksum(flocation):
    print("\n")
    print("#######################")
    print("SHA 256                ")
    print("#######################")
    print()
    hash_value = getSHA256(flocation)
    print(f"SHA256 Sum: {hash_value}")

def extractFile(flocation):
    print("\n")
    print("#######################")
    print("Extracting file        ")
    print("#######################")
    print()
    # decompress file
    archive = py7zr.SevenZipFile(flocation, mode='r')
    archive.extractall(path=home_dir)
    archive.close()

def copyFiles(rfolder):
    # home dir
    ruby_home = home_dir + "\\ruby"
    
    # Create the directory
    try:
        os.mkdir(ruby_home)
        print(f"Directory '{ruby_home}' created successfully.")
    except FileExistsError:
        print(f"Directory '{ruby_home}' already exists.")
    except PermissionError:
        print(f"Permission denied: Unable to create '{ruby_home}'.")
    except Exception as e:
        print(f"some kind of error occurred: {e}")
        sys.exit(0)

    print("\n")
    print("#######################")
    print("copying file           ")
    print("#######################")
    print("\n")
    # copying files over
    src = home_dir + "\\" + rfolder
    dst = ruby_home
    shutil.copytree(src,dst , dirs_exist_ok=True)
    print("done.")

    print("\n")
    print("#######################")
    print("Removing Source files  ")
    print("#######################")
    print("\n")
    # removing the extracted folder after decompression
    shutil.rmtree(src)
    print("done.")

def main():
    ra = checkForRuby()
    fl, rf = downloadRuby(ra)
    checksum(fl)
    extractFile(fl)
    copyFiles(rf)
    # leaving the 7z package file around
    # os.remove(fl)

if __name__ == "__main__":
    main()