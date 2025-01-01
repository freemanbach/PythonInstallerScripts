##############################################################################################################
# Author   : Freeman
# email    : flo@radford.edu
# Date     : 2024.12.27
# desc     : Pull the 7z archive ruby package to your Pc and extract it to your home location
# comments : You can certainly alter this code to get the devkit executable binary version with an installer.
# binary   : https://github.com/oneclick/rubyinstaller2/releases/download/RubyInstaller-3.3.6-2/rubyinstaller-devkit-3.3.6-2-x64.exe
##############################################################################################################
import sys, os, re, shutil

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

def main():
    home_dir = os.path.expanduser('~')

    if os.path.exists(home_dir + "\\" + "ruby"):
        print("Found Ruby installation .....")
        print("removing existing Ruby installation in user home directory.")
        shutil.rmtree(home_dir + "\\" + "ruby")

    print("##############################################################")
    print("                                                              ")    
    print("Will Install the latest version of Ruby Programming Lanaguage ")
    print("                                                              ")    
    print("##############################################################")        
    
    ruby_archive = []
    website = "https://rubyinstaller.org/downloads/index.html"
    ws = requests.get(website)

    if ws.status_code != 200:
        print("######################################")
        print("Ruby Windows Website is not available.")
        print("######################################")
        sys.exit()

    soup = BeautifulSoup( ws.content , 'html.parser') 
    for i in soup.find_all('a'):
        abc = str(i.get('href'))
        if abc.endswith(".7z"):
            ruby_archive.append(abc)

    ruby_url = ruby_archive[0]
    ruby_file = ruby_archive[0].split('/')[-1]
    ruby_folder = ruby_file.rsplit('.',1)[0]
    resp = requests.get(ruby_url, stream=True)
    file_location = home_dir + "\\" + ruby_file

    # Sizes in bytes.
    total_size = int(resp.headers.get("content-length", 0))
    block_size = 1024

    # download bar and write to FS
    if resp.status_code == 200:
        with tqdm(total=total_size, unit="B", unit_scale=True) as prog_bar:
            with open(file_location, "wb") as f:
                for data in resp.iter_content(block_size):
                    prog_bar.update(len(data))
                    f.write(data)
                print(f"\n\nFile downloaded successfully: {file_location}")
    else:
        print(f"\n\nFailed to download file. Status code: {resp.status_code}")
        sys.exit(0)
        
    # decompress file
    archive = py7zr.SevenZipFile(file_location, mode='r')
    archive.extractall(path=home_dir)
    archive.close()

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

    # copying files over
    src = home_dir + "\\" + ruby_folder
    dst = ruby_home
    shutil.copytree(src,dst , dirs_exist_ok=True)

    # removing the extracted folder after decompression
    shutil.rmtree(src)

    # leaving the 7z package file around
    # os.remove(file_location)

if __name__ == "__main__":
    main()