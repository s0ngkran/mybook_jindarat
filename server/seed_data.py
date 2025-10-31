import requests
from database import init_db, get_connection


def seed_books():
    init_db()

    conn = get_connection()
    cursor = conn.cursor()

    cursor.execute("SELECT COUNT(*) as count FROM book")
    if cursor.fetchone()["count"] > 0:
        print("Books already exist, skipping seed")
        conn.close()
        return
    conn.close()

    dummy_books = [
        {
            "imageUrl": "https://storage.naiin.com/system/application/bookstore/resource/product/202510/686097/1000285807_front_XXL.jpg?imgname=เชิดรักมังกรซ่อนเงาหงส์-เล่ม-4",
            "title": "เชิดรักมังกรซ่อนเงาหงส์ เล่ม 4",
            "reviewStar": 5,
            "price": 299.00,
            "isFav": False,
        },
        {
            "imageUrl": "https://storage.naiin.com/system/application/bookstore/resource/product/202509/684339/1000285092_front_XXL.jpg?imgname=ฟูมฟักจอมราชัน-เล่ม-4-(เล่มจบ)",
            "title": "ฟูมฟักจอมราชัน เล่ม 4 (เล่มจบ)",
            "reviewStar": 5,
            "price": 350.00,
            "isFav": False,
        },
        {
            "imageUrl": "https://storage.naiin.com/system/application/bookstore/resource/product/202409/623119/6000097879_front_XL.jpg?t=cat&imgname=Chained-Engineerล่ามรักวิศวะ",
            "title": "Chained Engineerล่ามรักวิศวะ",
            "reviewStar": 4,
            "price": 280.00,
            "isFav": False,
        },
        {
            "imageUrl": "https://storage.naiin.com/system/application/bookstore/resource/product/201701/206937/6000023956_front_XL.jpg?t=cat&imgname=VIP-DRAGON-มังกรสุดล้ำขย้ำหัวใจฯ",
            "title": "VIP DRAGON มังกรสุดล้ำขย้ำหัวใจฯ",
            "reviewStar": 5,
            "price": 320.00,
            "isFav": False,
        },
    ]

    api_url = "http://localhost:8000/books"
    success_count = 0

    for book in dummy_books:
        try:
            response = requests.post(api_url, json=book)
            response.raise_for_status()
            success_count += 1
            print(f"Created: {book['title']}")
        except requests.exceptions.RequestException as e:
            print(f"Failed to create {book['title']}: {e}")

    print(f"Seeded {success_count}/{len(dummy_books)} books successfully")


if __name__ == "__main__":
    seed_books()
