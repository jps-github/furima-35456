# テーブル設計

## users テーブル

| Column                | Type   | Options     |
| --------------------- | ------ | ----------- |
| nickname              | string | null: false |
| email                 | string | null: false |
| password              | string | null: false |
| first_name            | string | null: false |
| last_name             | string | null: false |
| first_name_katakana   | string | null: false |
| last_name_katakana    | string | null: false |
| birthday              | string | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column          | Type          | Options                        |
| --------------- | ------------- | ------------------------------ |
| image           | ActiveStorage | null: false                    |
| name            | string        | null: false                    |
| description     | text          | null: false                    |
| category        | string        | null: false                    |
| condition       | string        | null: false                    |
| delivery_charge | string        | null: false                    |
| delivery_area   | string        | null: false                    |
| delivery_days   | string        | null: false                    |
| price           | string        | null: false                    |
| user            | references    | null: false, foreign_key: true |

- belongs_to :users
- has_one :purchases

## purchases テーブル

| Column           | Type       | Options                        |
| ---------------- | ---------- | ------------------------------ |
| credit_card      | string     | null: false                    |
| expiration_month | string     | null: false                    |
| expiration_day   | string     | null: false                    |
| security_code    | string     | null: false                    |
| post_code        | string     | null: false                    |
| prefecture       | string     | null: false                    |
| city             | string     | null: false                    |
| address_1        | string     | null: false                    |
| address_2        | string     | null: false                    |
| phone_number     | string     | null: false                    |
| user             | references | null: false, foreign_key: true |
| item             | references | null: false, foreign_key: true |

- belongs_to :user
- belongs_to :item