#テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last_name          | string  | null: false               |
| first_name         | string  | null: false               |
| last_name_kana     | string  | null: false               |
| first_name_kana    | string  | null: false               |
| birth_date         | integer | null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user                | references | null: false, foreign_key: true |
| item_name           | string     | null: false                    |
| item_info           | text       | null: false                    |
| category            | integer    | null: false                    |
| sales_status        | integer    | null: false                    |
| shipping_fee_status | integer    | null: false                    |
| prefecture          | integer    | null: false, foreign_key: true |
| scheduled_delivery  | integer    | null: false                    |
| price               | string     | null: false                    |

### Association

- belongs_to :users
- has_many :orders

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |           |
| item_name | string     | null: false, foreign_key: true |

### Association

- has_one :shipping_addresses


##  shipping_addressesテーブル


| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| portal_code  | string     | null: false                    |
| prefecture   | integer    | null: false, foreign_key: true |
| city         | string     | null: false                    |
| addresses    | string     | null: false                    |
| building     | string     |                                |
| phone        | string     | null: false                    |
| user         | references | null: false, foreign_key: true |

- belongs_to ：orders

