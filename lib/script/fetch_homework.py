from bs4 import BeautifulSoup
from playwright.sync_api import sync_playwright
from func import get_date, get_pages, get_title
from graphql_client import GraphQLClient
import pyautogui

def send_to_hasura(date, pages, title, type):
    client = GraphQLClient("https://math-homework.hasura.app/v1/graphql")
    admin_secret = "W7wBDD3qIkyGFg37Ghxq9RMomixaRcELO9kC5NOprHmRzxKrRLrEsJXQyRnrIzMF"
    
    mutation = """
    mutation insertHomeworkAssignment($date: String!, $pages: [String!]!, $title: String!, $type: String) {
        insert_homework(objects: {date: $date, pages: $pages, title: $title, type: $type}) {
            affected_rows
        }
    }
    """
    
    variables = {
        "date": date,
        "pages": pages,
        "title": title,
        "type": type
    }
    
    headers = {"x-hasura-admin-secret": admin_secret}
    response = client.send(mutation, variables=variables, extra_headers=headers)

    if 'errors' not in response:
        data = response.get('data')
        print(f"Data inserted successfully! Affected rows: {data.get('insert_homework', {}).get('affected_rows')}")
    else:
        print(f"Error: {response['errors']}")
        print(variables)






def extract_homework_info(data:str):
    homework_list = []
    subjects = [
        "חדו״א",
        "גיאומטריה",
        "טריגונומטריה",
    ]
    for entry in data.split('מ  '):
        date = get_date(entry)
        subject = None
        for subj in subjects:
            if subj in entry:
                subject = subj
                break
        if subject is None:
            subject = 'אחר'
            
        title = get_title(entry)
        pages = get_pages(entry)

        homework_dict = {
            'date': date,
            'type': subject,
            'title': title,
            'pages': pages
        }

        homework_list.append(homework_dict)
    homework_list.pop(0)
    return homework_list



with sync_playwright() as p:
    browser = p.chromium.launch(headless=False, slow_mo=50)
    page = browser.new_page()
    page.goto("https://web.mashov.info/students/login")
    page.get_by_placeholder("ביה\"ס").click()
    page.get_by_placeholder("ביה\"ס").fill("כרמים")
    page.get_by_text("עתיד - כרמים בנימינה גבעת עדה (370395)").click()
    page.locator("#mat-select-value-1").click()
    pyautogui.click(200, 200)
    page.get_by_placeholder("שם משתמש / ת.ז").click()
    page.get_by_placeholder("שם משתמש / ת.ז").fill("327767901")
    page.get_by_placeholder("סיסמה (משו\"ב)").click()
    page.get_by_placeholder("סיסמה (משו\"ב)").fill("amitosh26")
    page.get_by_role("button", name="כניסה", exact=True).click()
    page.wait_for_timeout(2000)
    page.goto("https://web.mashov.info/students/main/students/0b5d240f-f005-4fd5-892a-c6b383e84e9d/homework")
    html = page.inner_html('mat-list')
    soup = BeautifulSoup(html, 'html.parser')
    text = soup.getText()
    homework_list = extract_homework_info(text)
    print(homework_list)
    for homework in homework_list:
        send_to_hasura(homework['date'], homework['pages'], homework['title'], homework['type'])
        




