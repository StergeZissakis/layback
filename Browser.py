import argparse
import logging
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.wait import WebDriverWait
from selenium.webdriver.common.action_chains import ActionChains
from selenium.webdriver.support import expected_conditions as ExpectedCondition
from selenium.webdriver.chrome.service import Service as ChromeService
import Utils


class Browser:
    headless = True
    page = None
    driver = None

    def __init__(self):
        parser = argparse.ArgumentParser()
        parser.add_argument("--headed", help='Headed mode', default=False, required=False)
        args = parser.parse_args()

        if args.headed:
            self.headless = False

        self.chrome_options = webdriver.ChromeOptions()
        self.chrome_options.add_argument('--no-sandbox')
        self.chrome_options.add_argument('--window-size=1920,1080')
        # self.chrome_options.add_argument("--incognito")
        self.chrome_options.add_argument('--start-maximized')
        self.chrome_options.add_argument('--disable-dev-shm-usage')
        self.chrome_options.add_argument('--disable-gpu')
        self.chrome_options.add_argument('--ignore-certificate-errors')
        self.chrome_options.add_argument('--allow-running-insecure-content')
        self.chrome_options.add_experimental_option("detach", True)
        # self.chrome_options.add_argument("user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.5615.49 Safari/537.36")
        self.chrome_options.add_argument("--enable-automation")
        self.chrome_options.add_argument("disable-infobars")
        self.chrome_options.add_argument("--disable-extensions")
        self.chrome_options.add_argument("--dns-prefetch-disable")
        # self.chrome_options.add_argument(PageLoadStrategy.NORMAL)
        # self.chrome_options.add_argument("--disable-browser-side-navigation")

        if self.headless:
            self.chrome_options.add_argument('--headless=new')
        
        service = ChromeService(executable_path="/usr/bin/chromedriver")
        #service = ChromeService(executable_path=".\\chromedriver.exe")
        self.driver = webdriver.Chrome(service=service, options=self.chrome_options)

    def __del__(self):
        pass

    def quit(self):
        logging.debug('Quiting...')
        self.driver.quit()

    def get(self, url):
        self.page = self.driver.get(url)
        return self.driver

    def get_no_reset(self, url):
        return self.driver.get(url)

    def reset_page_to_current(self):
        self.page = self.driver
        return self.page

    def reset_page(self, page):
        self.page = page

    def element_completely_visible(self, elem):
        elem_left_bound = elem.location.get('x')
        elem_top_bound = elem.location.get('y')
        elem_width = elem.size.get('width')
        elem_height = elem.size.get('height')
        elem_right_bound = elem_left_bound + elem_width
        elem_lower_bound = elem_top_bound + elem_height

        win_upper_bound = self.driver.execute_script('return window.pageYOffset')
        win_left_bound = self.driver.execute_script('return window.pageXOffset')
        win_width = self.driver.execute_script('return document.documentElement.clientWidth')
        win_height = self.driver.execute_script('return document.documentElement.clientHeight')
        win_right_bound = win_left_bound + win_width
        win_lower_bound = win_upper_bound + win_height

        return all(
                   (    win_left_bound <= elem_left_bound,
                        win_right_bound >= elem_right_bound,
                        win_upper_bound <= elem_top_bound,
                        win_lower_bound >= elem_lower_bound
                   )
                  )

    @staticmethod
    def get_interactible_child(element):
        if element and element.is_displayed() and element.is_enabled():
            logging.debug('Element not displayed or not enabled')
            return element

        ret = None
        for child in element.find_elements(By.XPATH, "./*"):
            if child and child.is_displayed() and child.is_enabled():
                ret = child
                break

        return ret

    @staticmethod
    def get_interactible_parent(element, parent_limit_xpath=""):
        if element and element.is_displayed() and element.is_enabled():
            return element

        parent_limit = None
        if len(parent_limit_xpath):
            parent_limit = element.find_element(By.XPATH, ".//ancestor::" + parent_limit_xpath)

        parent = element.find_element(By.XPATH, "..")
        if parent_limit and parent == parent_limit:
            return parent

        while parent and not (parent.is_displayed() and parent.is_enabled()):
            parent = parent.find_element(By.XPATH, "..")
            if parent_limit and parent == parent_limit:
                return parent

        if parent and parent.is_displayed() and parent.is_enabled():
            return parent
        elif parent_limit:
            return parent_limit
        else:
            return None

    def get_interactible(self, element, parent_limit_xpath=""):
        if element and element.is_displayed() and element.is_enabled():
            return element

        ret = self.get_interactible_child(element)
        if ret is None:
            ret = self.get_interactible_parent(element, parent_limit_xpath)

        return ret

    def scroll_to_visible(self, element, centre=False):
        if centre:
            self.driver.execute_script("arguments[0].scrollIntoView({block: 'center'});", element)
        else:
            self.driver.execute_script("arguments[0].scrollIntoView(true);", element)
        Utils.sleep_for_millis_random(400)

    def move_to_element(self, element):
        if self.element_completely_visible(element) and element.is_displayed():
            ActionChains(self.driver).move_to_element(element).perform()
        Utils.sleep_for_millis_random(300)

    def move_to_element_and_scroll_to_visible_bottom(self, element):
        self.move_to_element(element)
        Utils.sleep_for_millis_random(400)
        self.driver.execute_script("arguments[0].scrollIntoView(false);", element)

    def move_to_element_and_left_click(self, element, wait_sync_element_xpath="", parent_limit_xpath=""):
        self.move_to_element(element)
        clickable = self.get_interactible(element, parent_limit_xpath)
        if clickable:
            try:
                clickable.click()
            except  Exception as Argument:
                logging.exception("Exception in move_to_element_and_left_click")
                ActionChains(self.driver).move_to_element(clickable).click(clickable).perform()

            Utils.sleep_for_millis_random(150)
            if len(wait_sync_element_xpath):
                return self.wait_for_element_to_appear(wait_sync_element_xpath)
        return clickable

    def scroll_move_left_click(self, element, wait_sync_element_xpath="", parent_limit_xpath=""):
        self.scroll_to_visible(element, True)
        return self.move_to_element_and_left_click(element, wait_sync_element_xpath, parent_limit_xpath)

    def move_to_element_and_middle_click(self, element):
        self.move_to_element(element)
        clickable = self.get_interactible(element)
        if clickable:
            ActionChains(self.driver).key_down(Keys.CONTROL).click(clickable).key_up(Keys.CONTROL).perform()
            Utils.sleep_for_millis_random(300)

    def accept_cookies(self, button_xpath):
        try:
            self.wait_for_element_to_appear(button_xpath)
            button = self.driver.find_element(By.XPATH, button_xpath )
        except  Exception as Argument:
            logging.debug("accept_cookies failed: %s" % button_xpath)
            return

        if button:
            Utils.sleep_for_millis_random(700)
            self.move_to_element_and_left_click(button)

    def wait_for_element_to_appear(self, element_xpath, timeout=10):
        if len(element_xpath):
            try:
                return WebDriverWait(self.driver, timeout).until(ExpectedCondition.presence_of_element_located((By.XPATH, element_xpath)))
            except  Exception as Argument:
                logging.debug("Element has not appeared yet: %s" % element_xpath)
                pass
        return None

    @staticmethod
    def check_exists_by_xpath(element, xpath):
        try:
            element.find_element(By.XPATH, xpath)
        except  Exception as Argument:
            logging.debug("Element [%s] does not exist yet" % xpath)
            return False
        return True


    def switch_to_tab(self, tab_index, wait_for_elelemt_xpath=""):
        self.driver.switch_to.window(self.driver.window_handles[tab_index])
        self.page = self.driver
        if len(wait_for_elelemt_xpath):
            self.wait_for_element_to_appear(wait_for_elelemt_xpath)
        return self.page

    def close_tab(self, go_to_tab=0):
        self.driver.close()
        return self.switch_to_tab(go_to_tab)

    def close(self):
        self.driver.close()

    def go_back(self, times):
        for t in range(0, times):
            self.driver.execute_script('window.history.go(-1)')

            Utils.sleep_for_millis_random(150)
        return self.reset_page_to_current()

    def scroll_to_bottom(self):
        lenOfPage = self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);var lenOfPage=document.body.scrollHeight;return lenOfPage;")
        match = False
        while not match:
            lastCount = lenOfPage
            Utils.sleep_for_millis_random(2000)
            lenOfPage = self.driver.execute_script("window.scrollTo(0, document.body.scrollHeight);var lenOfPage=document.body.scrollHeight;return lenOfPage;")
            match = lastCount == lenOfPage
