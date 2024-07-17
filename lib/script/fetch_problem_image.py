from playwright.sync_api import sync_playwright
import yaml
from PIL import Image

def what_page(type:str):
    if type == "טריגונומטריה" or type == "חדו״א":
        return "ב"
    else:
        return "א"

def add_images_to_yaml(new_assets):
    with open('pubspec.yaml', 'r') as file:
        data = yaml.safe_load(file)
    if 'flutter' in data and 'assets' in data['flutter']:
        data['flutter']['assets'].extend(new_assets)
    else:
        data['flutter']['assets'] = new_assets
    with open('pubspec.yaml', 'w') as file:
        yaml.dump(data, file, default_flow_style=False)

def fetch_problem_images(pages : list[int], type = str):
    with sync_playwright() as p:
        browser = p.chromium.launch( headless=False)
        page = browser.new_page()
        page.goto("https://my.classoos.com/il/login/main")
        page.screenshot(path="screenshot.png")
        page.get_by_placeholder("דואר אלקטרוני").click()
        page.get_by_placeholder("דואר אלקטרוני").fill("amit.askof@gmail.com")
        page.get_by_placeholder("סיסמה").click()
        page.get_by_placeholder("סיסמה").fill("Classoos")
        page.get_by_role("button", name="התחבר").click()
        
        with page.expect_popup() as page2_info:
            page.locator("li").filter(has_text=f"מתמטיקה מתמטיקה שאלונים 804 ו-806 (כיתה י') כרך {what_page(type)} - 4 ו-5 יח\"ל - 2014").get_by_role("link").dblclick()
        page2 = page2_info.value
        for page in pages:
            image_path = f"assets/{page}{type}.png"
            page2.frame_locator("iframe[title=\"webviewer\"]").locator("[id=\"_pageNumberBox\"]").fill(str(page))
            page2.frame_locator("iframe[title=\"webviewer\"]").locator("[id=\"_pageNumberBox\"]").press("Enter")
            page2.wait_for_timeout(2500)
            page2.screenshot(path=image_path)
            with Image.open(image_path) as img:
                crop_box = (450, 70, 850, 700)  
                cropped_img = img.crop(crop_box)
                cropped_img.save(image_path)
            # add_images_to_yaml([image_path])
            
        
        
# fetch_problem_images([698, 700, 705], "טריגונומטריה")

