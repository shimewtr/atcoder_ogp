#!/usr/bin/env python
# -*- coding: utf-8 -*-

from selenium import webdriver
from selenium.webdriver.chrome.options import Options


def main():
    options = Options()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    driver.get("https://atcoder.jp/users/wawawatataru")
    driver.set_window_size(1920, 1080)
    driver.find_element_by_id("rating-graph-expand").click()
    png = driver.find_element_by_class_name("mt-2").screenshot_as_png
    with open("./docs/image/screenshot.png", "wb") as f:
        f.write(png)
    driver.close


if __name__ == "__main__":
    main()
