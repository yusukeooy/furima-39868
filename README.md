#テーブル設計

## users テーブル

| Column             | Type    | Options     |
| ------------------ | ------- | ----------- |
| nickname           | text    | null: false |
| email              | string  | null: false |
| encrypted_password | string  | null: false |
| name               | text    | null: false |
| name_kana          | text    | null: false |
| year               | integer | null: false |
| month              | integer | null: false |
| day                | integer | null: false |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column              | Type       | Options                        |
| ------------------- | ---------- | ------------------------------ |
| user                | references | null: false, foreign_key: true |
| item_name           | text       | null: false                    |
| item_info           | text       | null: false                    |
| category            | integer    | null: false                    |
| sales_status        | integer    | null: false                    |
| shipping_fee_status | integer    | null: false                    |
| prefecture          | integer    | null: false                    |
| scheduled_delivery  | integer    | null: false                    |
| price               | string     | null: false                    |

### Association

- belongs_to :users
- has_many :orders

## orders テーブル

| Column    | Type       | Options                        |
| --------- | ---------- | ------------------------------ |
| user      | references | null: false, foreign_key: true |           |
| item_name | text       | null: false, foreign_key: true |

### Association

- has_many :orders
- has_one :shipping_address


##  shipping_addressテーブル


| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| portal_code  | string     | null: false                    |
| prefecture   | integer    | null: false                    |
| city         | string     | null: false                    |
| addresses    | string     | null: false                    |
| building     | string     |                                |
| phone        | string     | null: false                    |

- belongs_to ：shipping_address

