#!/usr/bin/env python
# -*- coding: utf-8 -*-

import math
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from PIL import Image

image_path = "./docs/image/screenshot.png"


def main():
    capture_atcoder_rating()
    resize_image()


def capture_atcoder_rating():
    options = Options()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    driver.get("https://atcoder.jp/users/wawawatataru")
    driver.set_window_size(1920, 1080)
    driver.find_element_by_id("rating-graph-expand").click()
    png = driver.find_element_by_class_name("mt-2").screenshot_as_png
    with open(image_path, "wb") as f:
        f.write(png)
    driver.close


def resize_image():
    image = Image.open(image_path)
    width, height = image.size
    margin_width = 0
    margin_height = 0
    if width < height * 1.91:
        margin_width = math.floor((height * 1.91 - width) / 2)
    else:
        margin_height = math.floor((width / 1.91 - height) / 2)
    add_margin_image = Image.new(
        image.mode, (width + margin_width * 2, height + margin_height * 2), (255, 255, 255))
    add_margin_image.paste(image, (margin_width, margin_height))
    add_margin_image.save(image_path, quality=100)


if __name__ == "__main__":
    main()
