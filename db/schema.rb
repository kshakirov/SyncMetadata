# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160226151430) do

  create_table "backplate", id: false, force: :cascade do |t|
    t.integer "part_id",                     limit: 8,                            null: false
    t.integer "seal_type_id",                limit: 8
    t.string  "style_compressor_wheel",      limit: 100
    t.string  "seal_type",                   limit: 100
    t.decimal "overall_diameter",                        precision: 10, scale: 6
    t.decimal "compressor_wheel_diameter",               precision: 10, scale: 6
    t.decimal "piston_ring_diameter",                    precision: 10, scale: 6
    t.decimal "compressor_housing_diameter",             precision: 10, scale: 6
    t.string  "notes",                       limit: 500
    t.decimal "secondary_diameter",                      precision: 10, scale: 6
    t.decimal "overall_height",                          precision: 10, scale: 6
  end

  add_index "backplate", ["part_id"], name: "part_id", using: :btree

  create_table "bearing_housing", id: false, force: :cascade do |t|
    t.integer "part_id",             limit: 8,   null: false
    t.integer "cool_type_id",        limit: 8
    t.string  "oil_inlet",           limit: 100
    t.string  "oil_outlet",          limit: 100
    t.string  "oil",                 limit: 100
    t.string  "outlet_flange_holes", limit: 100
    t.string  "water_ports",         limit: 100
    t.string  "design_features",     limit: 100
    t.string  "bearing_type",        limit: 100
  end

  add_index "bearing_housing", ["part_id"], name: "part_id", using: :btree

  create_table "bearing_spacer", id: false, force: :cascade do |t|
    t.integer "part_id",         limit: 8,                          null: false
    t.decimal "outside_dim_min",           precision: 10, scale: 6
    t.decimal "outside_dim_max",           precision: 10, scale: 6
    t.decimal "inside_dim_min",            precision: 10, scale: 6
    t.decimal "inside_dim_max",            precision: 10, scale: 6
  end

  add_index "bearing_spacer", ["part_id"], name: "part_id", using: :btree

  create_table "bom", force: :cascade do |t|
    t.integer "parent_part_id", limit: 8, null: false
    t.integer "child_part_id",  limit: 8, null: false
    t.integer "quantity",       limit: 4, null: false
  end

  add_index "bom", ["child_part_id"], name: "child_part_id", using: :btree
  add_index "bom", ["parent_part_id", "child_part_id"], name: "parent_part_id", unique: true, using: :btree

  create_table "bom_alt_header", force: :cascade do |t|
    t.string "name",        limit: 255
    t.string "description", limit: 255
  end

  create_table "bom_alt_item", force: :cascade do |t|
    t.integer "bom_alt_header_id", limit: 8, null: false
    t.integer "bom_id",            limit: 8, null: false
    t.integer "part_id",           limit: 8, null: false
  end

  add_index "bom_alt_item", ["bom_alt_header_id", "bom_id"], name: "bom_alt_header_id", unique: true, using: :btree
  add_index "bom_alt_item", ["bom_id"], name: "bom_id", using: :btree
  add_index "bom_alt_item", ["part_id"], name: "part_id", using: :btree

  create_table "bom_descendant", force: :cascade do |t|
    t.integer "part_bom_id",       limit: 8,  null: false
    t.integer "descendant_bom_id", limit: 8,  null: false
    t.integer "distance",          limit: 4,  null: false
    t.string  "type",              limit: 20
    t.integer "qty",               limit: 4,  null: false
  end

  add_index "bom_descendant", ["descendant_bom_id"], name: "descendant_bom_id", using: :btree
  add_index "bom_descendant", ["distance"], name: "distance", using: :btree
  add_index "bom_descendant", ["part_bom_id", "descendant_bom_id", "distance", "type", "qty"], name: "part_bom_id", unique: true, using: :btree
  add_index "bom_descendant", ["part_bom_id", "type", "distance", "descendant_bom_id"], name: "part_bom_id_2", using: :btree

  create_table "car_engine", force: :cascade do |t|
    t.string  "engine_size",      limit: 50, null: false
    t.integer "car_fuel_type_id", limit: 8
  end

  add_index "car_engine", ["car_fuel_type_id"], name: "car_fuel_type_id", using: :btree
  add_index "car_engine", ["engine_size", "car_fuel_type_id"], name: "engine_size", unique: true, using: :btree

  create_table "car_fuel_type", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "car_fuel_type", ["name"], name: "name", unique: true, using: :btree

  create_table "car_make", force: :cascade do |t|
    t.string  "name",      limit: 50, null: false
    t.integer "import_pk", limit: 8
  end

  add_index "car_make", ["name"], name: "name", unique: true, using: :btree

  create_table "car_model", force: :cascade do |t|
    t.string  "name",        limit: 50, null: false
    t.integer "car_make_id", limit: 8,  null: false
    t.integer "import_pk",   limit: 8
  end

  add_index "car_model", ["car_make_id"], name: "car_make_id", using: :btree
  add_index "car_model", ["name", "car_make_id"], name: "name", unique: true, using: :btree

  create_table "car_model_engine_year", force: :cascade do |t|
    t.integer "car_model_id",  limit: 8
    t.integer "car_engine_id", limit: 8
    t.integer "car_year_id",   limit: 8
    t.integer "import_pk",     limit: 8
  end

  add_index "car_model_engine_year", ["car_engine_id"], name: "car_engine_id", using: :btree
  add_index "car_model_engine_year", ["car_model_id", "car_engine_id", "car_year_id"], name: "car_model_id", unique: true, using: :btree
  add_index "car_model_engine_year", ["car_year_id"], name: "car_year_id", using: :btree

  create_table "car_year", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "car_year", ["name"], name: "name", unique: true, using: :btree

  create_table "cartridge", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "cartridge", ["part_id"], name: "part_id", using: :btree

  create_table "changelog", force: :cascade do |t|
    t.datetime "change_date",                    null: false
    t.integer  "user_id",     limit: 8,          null: false
    t.string   "description", limit: 255,        null: false
    t.text     "data",        limit: 4294967295
  end

  add_index "changelog", ["change_date"], name: "change_date", using: :btree
  add_index "changelog", ["user_id"], name: "user_id", using: :btree

  create_table "compressor_wheel", id: false, force: :cascade do |t|
    t.integer "part_id",        limit: 8,                            null: false
    t.decimal "inducer_oa",                 precision: 10, scale: 6
    t.decimal "tip_height_b",               precision: 10, scale: 6
    t.decimal "exducer_oc",                 precision: 10, scale: 6
    t.decimal "hub_length_d",               precision: 10, scale: 6
    t.decimal "bore_oe",                    precision: 10, scale: 6
    t.string  "trim_no_blades", limit: 100
    t.string  "application",    limit: 100
  end

  add_index "compressor_wheel", ["part_id"], name: "part_id", using: :btree

  create_table "cool_type", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.integer "import_pk", limit: 8
  end

  add_index "cool_type", ["name"], name: "name", unique: true, using: :btree

  create_table "deleted_parts", id: false, force: :cascade do |t|
    t.integer  "id", limit: 8, null: false
    t.datetime "dt"
  end

  add_index "deleted_parts", ["id"], name: "id", unique: true, using: :btree

  create_table "external_systems", force: :cascade do |t|
    t.string   "url",              limit: 255
    t.text     "description",      limit: 65535
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "sales_notes_last", limit: 4,     default: 0
    t.integer  "images_last",      limit: 4,     default: 0
  end

  create_table "gasket", id: false, force: :cascade do |t|
    t.integer "part_id",        limit: 8, null: false
    t.integer "gasket_type_id", limit: 8, null: false
  end

  add_index "gasket", ["gasket_type_id"], name: "gasket_type_id", using: :btree
  add_index "gasket", ["part_id"], name: "part_id", using: :btree

  create_table "gasket_type", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.integer "import_pk", limit: 8
  end

  add_index "gasket_type", ["name"], name: "name", unique: true, using: :btree

  create_table "group_role", id: false, force: :cascade do |t|
    t.integer "group_id", limit: 8, null: false
    t.integer "role_id",  limit: 8, null: false
  end

  add_index "group_role", ["role_id"], name: "role_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string  "name",    limit: 100,             null: false
    t.integer "version", limit: 4,   default: 1, null: false
  end

  add_index "groups", ["name"], name: "name", unique: true, using: :btree

  create_table "heatshield", id: false, force: :cascade do |t|
    t.integer "part_id",          limit: 8,                            null: false
    t.decimal "overall_diameter",             precision: 10, scale: 6
    t.decimal "inside_diameter",              precision: 10, scale: 6
    t.decimal "inducer_diameter",             precision: 10, scale: 6
    t.string  "notes",            limit: 500
  end

  add_index "heatshield", ["part_id"], name: "part_id", using: :btree

  create_table "i_interchange_log", force: :cascade do |t|
    t.string   "description",           limit: 250
    t.integer  "part_num_id",           limit: 8
    t.integer  "interchange_header_id", limit: 8
    t.integer  "interchange_cnt_uniq",  limit: 8
    t.datetime "date",                              null: false
  end

  create_table "interchange_header", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.string  "description", limit: 255
    t.integer "new_part_id", limit: 8
  end

  add_index "interchange_header", ["new_part_id"], name: "new_part_id_UNIQUE", unique: true, using: :btree

  create_table "interchange_item", primary_key: "part_id", force: :cascade do |t|
    t.integer "interchange_header_id", limit: 8, null: false
  end

  add_index "interchange_item", ["interchange_header_id"], name: "interchange_header_id", using: :btree

  create_table "journal_bearing", id: false, force: :cascade do |t|
    t.integer "part_id",         limit: 8,                          null: false
    t.decimal "outside_dim_min",           precision: 10, scale: 6, null: false
    t.decimal "outside_dim_max",           precision: 10, scale: 6, null: false
    t.decimal "inside_dim_min",            precision: 10, scale: 6, null: false
    t.decimal "inside_dim_max",            precision: 10, scale: 6, null: false
    t.decimal "width",                     precision: 10, scale: 6, null: false
  end

  add_index "journal_bearing", ["part_id"], name: "part_id", using: :btree

  create_table "kit", id: false, force: :cascade do |t|
    t.integer "part_id",     limit: 8, null: false
    t.integer "kit_type_id", limit: 8, null: false
  end

  add_index "kit", ["kit_type_id"], name: "kit_type_id", using: :btree
  add_index "kit", ["part_id"], name: "part_id", using: :btree

  create_table "kit_part_common_component", force: :cascade do |t|
    t.integer "kit_id",  limit: 8, null: false
    t.integer "part_id", limit: 8, null: false
    t.binary  "exclude", limit: 1, null: false
  end

  add_index "kit_part_common_component", ["kit_id", "part_id"], name: "kit_id", unique: true, using: :btree
  add_index "kit_part_common_component", ["part_id"], name: "part_id", using: :btree

  create_table "kit_type", force: :cascade do |t|
    t.string  "name",      limit: 1000, null: false
    t.integer "import_pk", limit: 8
  end

  create_table "manfr", force: :cascade do |t|
    t.string  "name",            limit: 255, null: false
    t.integer "manfr_type_id",   limit: 8,   null: false
    t.integer "parent_manfr_id", limit: 8
    t.integer "import_pk",       limit: 8
  end

  add_index "manfr", ["manfr_type_id"], name: "manfr_type_id", using: :btree
  add_index "manfr", ["name"], name: "name", unique: true, using: :btree
  add_index "manfr", ["parent_manfr_id"], name: "parent_manfr_id", using: :btree

  create_table "manfr_type", force: :cascade do |t|
    t.string "name", limit: 255, null: false
  end

  add_index "manfr_type", ["name"], name: "name", unique: true, using: :btree

  create_table "mas90_std_price", id: false, force: :cascade do |t|
    t.string  "ItemNumber", limit: 50,                                        null: false
    t.decimal "StdPrice",              precision: 10, scale: 2, default: 0.0, null: false
  end

  create_table "nozzle_ring", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, null: false
  end

  add_index "nozzle_ring", ["part_id"], name: "part_id", using: :btree

  create_table "part", force: :cascade do |t|
    t.string  "manfr_part_num", limit: 255,                 null: false
    t.integer "manfr_id",       limit: 8,                   null: false
    t.integer "part_type_id",   limit: 8,                   null: false
    t.string  "name",           limit: 255
    t.string  "description",    limit: 255
    t.boolean "inactive",                   default: false, null: false
    t.integer "import_pk",      limit: 8
    t.integer "version",        limit: 4,   default: 1,     null: false
  end

  add_index "part", ["id", "version"], name: "id", unique: true, using: :btree
  add_index "part", ["manfr_id"], name: "manfr_id", using: :btree
  add_index "part", ["manfr_part_num", "manfr_id"], name: "manfr_part_num", unique: true, using: :btree
  add_index "part", ["part_type_id"], name: "part_type_id", using: :btree

  create_table "part_turbo", force: :cascade do |t|
    t.integer "part_id",  limit: 8, null: false
    t.integer "turbo_id", limit: 8, null: false
  end

  add_index "part_turbo", ["part_id"], name: "part_id", using: :btree
  add_index "part_turbo", ["turbo_id"], name: "turbo_id", using: :btree

  create_table "part_turbo_type", id: false, force: :cascade do |t|
    t.integer "part_id",       limit: 8, null: false
    t.integer "turbo_type_id", limit: 8, null: false
  end

  add_index "part_turbo_type", ["turbo_type_id"], name: "turbo_type_id", using: :btree

  create_table "part_type", force: :cascade do |t|
    t.string  "name",                  limit: 255, null: false
    t.integer "parent_part_type_id",   limit: 8
    t.integer "import_pk",             limit: 8
    t.string  "magento_attribute_set", limit: 50
    t.string  "value",                 limit: 50,  null: false
  end

  add_index "part_type", ["parent_part_type_id"], name: "parent_part_type_id", using: :btree
  add_index "part_type", ["value"], name: "value_UNIQUE", unique: true, using: :btree

  create_table "piston_ring", id: false, force: :cascade do |t|
    t.integer "part_id",         limit: 8,                          null: false
    t.decimal "outside_dim_min",           precision: 10, scale: 6
    t.decimal "outside_dim_max",           precision: 10, scale: 6
    t.decimal "width_min",                 precision: 10, scale: 6
    t.decimal "width_max",                 precision: 10, scale: 6
    t.decimal "i_gap_min",                 precision: 10, scale: 6
    t.decimal "i_gap_max",                 precision: 10, scale: 6
  end

  add_index "piston_ring", ["part_id"], name: "part_id", using: :btree

  create_table "product_image", force: :cascade do |t|
    t.integer "part_id",  limit: 8,   null: false
    t.string  "filename", limit: 255
  end

  add_index "product_image", ["filename"], name: "filename", unique: true, using: :btree
  add_index "product_image", ["part_id"], name: "part_id", using: :btree

  create_table "products_images_audits", force: :cascade do |t|
    t.string   "action",     limit: 255
    t.integer  "image_id",   limit: 4
    t.integer  "part_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "role", force: :cascade do |t|
    t.string "name",    limit: 100, null: false
    t.string "display", limit: 100, null: false
  end

  add_index "role", ["name"], name: "name", unique: true, using: :btree

  create_table "sales_note", force: :cascade do |t|
    t.datetime "create_date",                    null: false
    t.datetime "write_date",                     null: false
    t.integer  "create_uid",  limit: 8,          null: false
    t.integer  "write_uid",   limit: 8,          null: false
    t.string   "state",       limit: 15,         null: false
    t.text     "comment",     limit: 4294967295, null: false
  end

  add_index "sales_note", ["create_uid"], name: "fk_sales_note_user_create_uid_idx", using: :btree
  add_index "sales_note", ["write_uid"], name: "fk_sales_note_user_write_uid_idx", using: :btree

  create_table "sales_note_attachment", force: :cascade do |t|
    t.datetime "create_date",              null: false
    t.datetime "write_date",               null: false
    t.integer  "create_uid",    limit: 8,  null: false
    t.integer  "write_uid",     limit: 8,  null: false
    t.integer  "sales_note_id", limit: 8,  null: false
    t.string   "filename",      limit: 45, null: false
  end

  add_index "sales_note_attachment", ["create_uid"], name: "fk_sales_note_attachment_user_create_uid_idx", using: :btree
  add_index "sales_note_attachment", ["sales_note_id", "filename"], name: "sales_note_id_filename", unique: true, using: :btree
  add_index "sales_note_attachment", ["sales_note_id"], name: "sales_note_attachment_sales_note_sales_note_id_idx", using: :btree
  add_index "sales_note_attachment", ["write_uid"], name: "fk_sales_note_attachment_user_write_uid_idx", using: :btree

  create_table "sales_note_part", id: false, force: :cascade do |t|
    t.integer  "sales_note_id", limit: 8, null: false
    t.integer  "part_id",       limit: 8, null: false
    t.datetime "create_date",             null: false
    t.datetime "write_date",              null: false
    t.integer  "create_uid",    limit: 8, null: false
    t.integer  "write_uid",     limit: 8, null: false
    t.boolean  "primary_part"
  end

  add_index "sales_note_part", ["create_uid"], name: "sales_note_part_user_create_uid_idx", using: :btree
  add_index "sales_note_part", ["part_id"], name: "sales_note_part_part_part_id_idx", using: :btree
  add_index "sales_note_part", ["sales_note_id", "primary_part"], name: "sales_note_part_primary_part_unq_idx", unique: true, using: :btree
  add_index "sales_note_part", ["write_uid"], name: "sales_note_part_user_write_uid_idx", using: :btree

  create_table "sales_notes_audits", force: :cascade do |t|
    t.string   "action",        limit: 255
    t.integer  "sales_note_id", limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "seal_type", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.integer "import_pk", limit: 8,   null: false
  end

  add_index "seal_type", ["name"], name: "name", unique: true, using: :btree

  create_table "standard_bearing_spacer", id: false, force: :cascade do |t|
    t.integer "standard_part_id",  limit: 8, null: false
    t.integer "oversized_part_id", limit: 8, null: false
  end

  add_index "standard_bearing_spacer", ["oversized_part_id"], name: "oversized_part_id", using: :btree

  create_table "standard_journal_bearing", id: false, force: :cascade do |t|
    t.integer "standard_part_id",  limit: 8, null: false
    t.integer "oversized_part_id", limit: 8, null: false
  end

  add_index "standard_journal_bearing", ["oversized_part_id"], name: "oversized_part_id", using: :btree

  create_table "standard_oversize_part", id: false, force: :cascade do |t|
    t.integer "standard_part_id", limit: 8, null: false
    t.integer "oversize_part_id", limit: 8, null: false
  end

  add_index "standard_oversize_part", ["oversize_part_id"], name: "standard_oversize_part_oversized_part_id_idx", using: :btree

  create_table "test_ii", id: false, force: :cascade do |t|
    t.integer "p_id",                  limit: 8, default: 0, null: false
    t.integer "interchange_header_id", limit: 8
    t.integer "pi_id",                 limit: 8, default: 0
    t.integer "part_id",               limit: 8
  end

  create_table "test_pi", id: false, force: :cascade do |t|
    t.integer "id",                    limit: 8, default: 0, null: false
    t.integer "interchange_header_id", limit: 8
    t.integer "part_id",               limit: 8
    t.integer "part_id_comb",          limit: 8
  end

  create_table "test_vmagmi_service_kits", id: false, force: :cascade do |t|
    t.integer "sku",             limit: 8,   default: 0, null: false
    t.integer "kitSku",          limit: 8,   default: 0, null: false
    t.string  "kitPartNumber",   limit: 255,             null: false
    t.string  "description",     limit: 255
    t.integer "tiKitSku",        limit: 8,   default: 0
    t.string  "tiKitPartNumber", limit: 255
  end

  create_table "turbine_wheel", id: false, force: :cascade do |t|
    t.integer "part_id",        limit: 8,                            null: false
    t.decimal "exduce_oa",                  precision: 10, scale: 6
    t.decimal "tip_height_b",               precision: 10, scale: 6
    t.decimal "inducer_oc",                 precision: 10, scale: 6
    t.decimal "journal_od",                 precision: 10, scale: 6
    t.decimal "stem_oe",                    precision: 10, scale: 6
    t.string  "trim_no_blades", limit: 100
    t.string  "shaft_thread_f", limit: 100
  end

  add_index "turbine_wheel", ["part_id"], name: "part_id", using: :btree

  create_table "turbo", id: false, force: :cascade do |t|
    t.integer "part_id",        limit: 8, null: false
    t.integer "turbo_model_id", limit: 8, null: false
    t.integer "cool_type_id",   limit: 8
  end

  add_index "turbo", ["cool_type_id"], name: "cool_type_id", using: :btree
  add_index "turbo", ["part_id"], name: "part_id", using: :btree
  add_index "turbo", ["turbo_model_id"], name: "turbo_model_id", using: :btree

  create_table "turbo_car_model_engine_year", id: false, force: :cascade do |t|
    t.integer "part_id",                  limit: 8, null: false
    t.integer "car_model_engine_year_id", limit: 8, null: false
    t.integer "import_pk",                limit: 8
  end

  add_index "turbo_car_model_engine_year", ["car_model_engine_year_id"], name: "car_model_engine_year_id", using: :btree

  create_table "turbo_model", force: :cascade do |t|
    t.string  "name",          limit: 255
    t.integer "turbo_type_id", limit: 8
    t.integer "import_pk",     limit: 8
  end

  add_index "turbo_model", ["turbo_type_id"], name: "turbo_type_id", using: :btree

  create_table "turbo_type", force: :cascade do |t|
    t.string  "name",      limit: 255, null: false
    t.integer "manfr_id",  limit: 8,   null: false
    t.integer "import_pk", limit: 8
  end

  add_index "turbo_type", ["manfr_id"], name: "manfr_id", using: :btree
  add_index "turbo_type", ["name", "manfr_id"], name: "name", unique: true, using: :btree

  create_table "user", force: :cascade do |t|
    t.string  "name",                 limit: 100,                null: false
    t.string  "email",                limit: 255,                null: false
    t.string  "password",             limit: 100,                null: false
    t.string  "password_reset_token", limit: 36
    t.boolean "enabled",                          default: true, null: false
  end

  add_index "user", ["email"], name: "email", unique: true, using: :btree
  add_index "user", ["password_reset_token"], name: "password_reset_token", unique: true, using: :btree

  create_table "user_group", id: false, force: :cascade do |t|
    t.integer "user_id",  limit: 8, null: false
    t.integer "group_id", limit: 8, null: false
  end

  add_index "user_group", ["group_id"], name: "group_id", using: :btree

  create_table "vapp", id: false, force: :cascade do |t|
    t.integer "part_id",   limit: 8,   default: 0, null: false
    t.string  "car_make",  limit: 50
    t.string  "car_year",  limit: 255
    t.string  "car_model", limit: 50
  end

  create_table "vbalt", id: false, force: :cascade do |t|
    t.integer "bom_id",              limit: 8,               null: false
    t.integer "child_part_id",       limit: 8,               null: false
    t.integer "bom_alt_header_id",   limit: 8,               null: false
    t.string  "alt_header_name",     limit: 255
    t.string  "alt_header_desc",     limit: 255
    t.integer "alt_part_id",         limit: 8,               null: false
    t.string  "alt_part_type",       limit: 255,             null: false
    t.string  "alt_part_number",     limit: 255,             null: false
    t.string  "alt_manufacturer",    limit: 255,             null: false
    t.integer "alt_manufacturer_id", limit: 8,   default: 0, null: false
  end

  create_table "vbom", id: false, force: :cascade do |t|
    t.integer "bom_id",         limit: 8,   default: 0, null: false
    t.integer "p_part_id",      limit: 8,   default: 0, null: false
    t.string  "p_part_type",    limit: 255,             null: false
    t.string  "p_part_number",  limit: 255,             null: false
    t.string  "p_manufacturer", limit: 255,             null: false
    t.integer "c_part_id",      limit: 8,   default: 0, null: false
    t.string  "c_part_type",    limit: 255,             null: false
    t.string  "c_part_number",  limit: 255,             null: false
    t.string  "c_manufacturer", limit: 255,             null: false
  end

  create_table "vbom_ancestor", id: false, force: :cascade do |t|
    t.integer "id",               limit: 8,  default: 0, null: false
    t.integer "part_id",          limit: 8,              null: false
    t.integer "ancestor_part_id", limit: 8,              null: false
    t.integer "distance",         limit: 4,              null: false
    t.string  "type",             limit: 20
  end

  create_table "vbom_descendant", id: false, force: :cascade do |t|
    t.integer "id",                 limit: 8,  default: 0, null: false
    t.integer "part_bom_id",        limit: 8,              null: false
    t.integer "descendant_bom_id",  limit: 8,              null: false
    t.integer "distance",           limit: 4,              null: false
    t.string  "type",               limit: 20
    t.integer "qty",                limit: 4,              null: false
    t.integer "part_id_ancestor",   limit: 8,              null: false
    t.integer "part_id_descendant", limit: 8,              null: false
  end

  create_table "vbom_descendant_direct", id: false, force: :cascade do |t|
    t.integer "id",                 limit: 8,  default: 0, null: false
    t.integer "part_bom_id",        limit: 8,              null: false
    t.integer "descendant_bom_id",  limit: 8,              null: false
    t.integer "distance",           limit: 4,              null: false
    t.string  "type",               limit: 20
    t.integer "qty",                limit: 4,              null: false
    t.integer "part_id_ancestor",   limit: 8,              null: false
    t.integer "part_id_descendant", limit: 8,              null: false
  end

  create_table "vint", id: false, force: :cascade do |t|
    t.integer "interchange_header_id", limit: 8,               null: false
    t.integer "part_id",               limit: 8,   default: 0, null: false
    t.string  "part_type",             limit: 255,             null: false
    t.string  "part_number",           limit: 255,             null: false
    t.string  "manufacturer",          limit: 255,             null: false
    t.integer "i_part_id",             limit: 8,   default: 0
    t.string  "i_part_type",           limit: 255,             null: false
    t.string  "i_part_number",         limit: 255
    t.string  "i_manufacturer",        limit: 255
  end

  create_table "vint_ti", id: false, force: :cascade do |t|
    t.integer "interchange_header_id", limit: 8,             null: false
    t.integer "part_id",               limit: 8, default: 0, null: false
    t.integer "ti_part_id",            limit: 8, default: 0
  end

  create_table "vkp", id: false, force: :cascade do |t|
    t.integer "kit_id",  limit: 8, null: false
    t.integer "part_id", limit: 8, null: false
    t.binary  "exclude", limit: 1, null: false
  end

  create_table "vmagmi_bom", id: false, force: :cascade do |t|
    t.integer "ancestor_sku",     limit: 8,              null: false
    t.integer "descendant_sku",   limit: 8,              null: false
    t.integer "quantity",         limit: 4,              null: false
    t.integer "distance",         limit: 4,              null: false
    t.string  "type",             limit: 20
    t.string  "part_type_parent", limit: 50
    t.integer "has_bom",          limit: 4,  default: 0, null: false
    t.integer "alt_sku",          limit: 8
    t.integer "alt_mfr_id",       limit: 8,  default: 0
    t.integer "int_sku",          limit: 8,  default: 0
  end

  create_table "vmagmi_service_kits", id: false, force: :cascade do |t|
    t.integer "sku",             limit: 8,   default: 0, null: false
    t.integer "kitSku",          limit: 8,   default: 0, null: false
    t.string  "kitPartNumber",   limit: 255,             null: false
    t.string  "description",     limit: 255
    t.integer "tiKitSku",        limit: 8,   default: 0
    t.string  "tiKitPartNumber", limit: 255
  end

  create_table "vmagmi_sop", id: false, force: :cascade do |t|
    t.integer "part_id",            limit: 8,   default: 0, null: false
    t.integer "standard_part_sku",  limit: 8,   default: 0, null: false
    t.string  "oversize_part_skus", limit: 341
  end

  create_table "vmagmi_ti_chra", id: false, force: :cascade do |t|
    t.integer "id",          limit: 8, default: 0,  null: false
    t.string  "has_ti_chra", limit: 3, default: "", null: false
  end

  create_table "vpart_turbo", id: false, force: :cascade do |t|
    t.integer "part_id",  limit: 8, default: 0, null: false
    t.integer "turbo_id", limit: 8, default: 0, null: false
  end

  create_table "vpart_turbotype_kits", id: false, force: :cascade do |t|
    t.integer "part_id", limit: 8, default: 0, null: false
    t.integer "kit_id",  limit: 8, default: 0, null: false
  end

  create_table "vparts", id: false, force: :cascade do |t|
    t.integer "part_id",      limit: 8,   default: 0, null: false
    t.string  "part_type",    limit: 255,             null: false
    t.string  "part_number",  limit: 255,             null: false
    t.string  "manufacturer", limit: 255,             null: false
  end

  create_table "vtapp", id: false, force: :cascade do |t|
    t.integer "part_id",   limit: 8,   null: false
    t.string  "car_make",  limit: 50
    t.string  "car_year",  limit: 255
    t.string  "car_model", limit: 50
  end

  create_table "vwhere_used", id: false, force: :cascade do |t|
    t.integer "principal_id",      limit: 8,   default: 0, null: false
    t.string  "principal_type",    limit: 255,             null: false
    t.integer "sku",               limit: 8,   default: 0, null: false
    t.string  "manufacturer",      limit: 255,             null: false
    t.string  "part_number",       limit: 255,             null: false
    t.integer "ti_sku",            limit: 8,   default: 0
    t.string  "ti_part_number",    limit: 255
    t.string  "part_type",         limit: 255,             null: false
    t.string  "turbo_type",        limit: 255
    t.string  "turbo_part_number", limit: 255
  end

  add_foreign_key "backplate", "part", name: "backplate_ibfk_1"
  add_foreign_key "bearing_housing", "part", name: "bearing_housing_ibfk_1"
  add_foreign_key "bearing_spacer", "part", name: "bearing_spacer_ibfk_1"
  add_foreign_key "bom", "part", column: "child_part_id", name: "bom_ibfk_2"
  add_foreign_key "bom", "part", column: "parent_part_id", name: "bom_ibfk_1"
  add_foreign_key "bom_alt_item", "bom", name: "bom_alt_item_ibfk_2"
  add_foreign_key "bom_alt_item", "bom_alt_header", name: "bom_alt_item_ibfk_1"
  add_foreign_key "bom_alt_item", "part", name: "bom_alt_item_ibfk_3"
  add_foreign_key "bom_descendant", "bom", column: "descendant_bom_id", name: "bom_descendant_ibfk_4", on_delete: :cascade
  add_foreign_key "bom_descendant", "bom", column: "part_bom_id", name: "bom_descendant_ibfk_3", on_delete: :cascade
  add_foreign_key "car_engine", "car_fuel_type", name: "car_engine_ibfk_1"
  add_foreign_key "car_model", "car_make", name: "car_model_ibfk_1"
  add_foreign_key "car_model_engine_year", "car_engine", name: "car_model_engine_year_ibfk_2"
  add_foreign_key "car_model_engine_year", "car_model", name: "car_model_engine_year_ibfk_1"
  add_foreign_key "car_model_engine_year", "car_year", name: "car_model_engine_year_ibfk_3"
  add_foreign_key "cartridge", "part", name: "cartridge_ibfk_1"
  add_foreign_key "changelog", "user", name: "changelog_ibfk_1"
  add_foreign_key "compressor_wheel", "part", name: "compressor_wheel_ibfk_1"
  add_foreign_key "gasket", "gasket_type", name: "gasket_ibfk_2"
  add_foreign_key "gasket", "part", name: "gasket_ibfk_1"
  add_foreign_key "group_role", "groups", name: "group_role_ibfk_1"
  add_foreign_key "group_role", "role", name: "group_role_ibfk_2"
  add_foreign_key "heatshield", "part", name: "heatshield_ibfk_1"
  add_foreign_key "interchange_header", "part", column: "new_part_id", name: "new_part_id"
  add_foreign_key "interchange_item", "interchange_header", name: "interchange_item_ibfk_1"
  add_foreign_key "interchange_item", "part", name: "interchange_item_ibfk_2"
  add_foreign_key "journal_bearing", "part", name: "journal_bearing_ibfk_1"
  add_foreign_key "kit", "kit_type", name: "kit_ibfk_1"
  add_foreign_key "kit", "part", name: "kit_ibfk_2"
  add_foreign_key "kit_part_common_component", "part", column: "kit_id", name: "kit_part_common_component_ibfk_1"
  add_foreign_key "kit_part_common_component", "part", name: "kit_part_common_component_ibfk_2"
  add_foreign_key "manfr", "manfr", column: "parent_manfr_id", name: "manfr_ibfk_2"
  add_foreign_key "manfr", "manfr_type", name: "manfr_ibfk_1"
  add_foreign_key "nozzle_ring", "part", name: "nozzle_ring_ibfk_1"
  add_foreign_key "part", "manfr", name: "part_ibfk_1"
  add_foreign_key "part", "part_type", name: "part_ibfk_2"
  add_foreign_key "part_turbo", "part", name: "part_turbo_ibfk_1"
  add_foreign_key "part_turbo", "turbo", primary_key: "part_id", name: "part_turbo_ibfk_2"
  add_foreign_key "part_turbo_type", "part", name: "part_turbo_type_ibfk_1"
  add_foreign_key "part_turbo_type", "turbo_type", name: "part_turbo_type_ibfk_2"
  add_foreign_key "part_type", "part_type", column: "parent_part_type_id", name: "part_type_ibfk_1"
  add_foreign_key "piston_ring", "part", name: "piston_ring_ibfk_1"
  add_foreign_key "product_image", "part", name: "product_image_ibfk_1"
  add_foreign_key "sales_note", "user", column: "create_uid", name: "fk_sales_note_user_create_uid"
  add_foreign_key "sales_note", "user", column: "write_uid", name: "fk_sales_note_user_write_uid"
  add_foreign_key "sales_note_attachment", "sales_note", name: "sales_note_attachment_sales_note_sales_note_id"
  add_foreign_key "sales_note_attachment", "user", column: "create_uid", name: "sales_note_attachment_user_create_uid"
  add_foreign_key "sales_note_attachment", "user", column: "write_uid", name: "sales_note_attachment_user_write_uid"
  add_foreign_key "sales_note_part", "part", name: "sales_note_part_part_part_id", on_delete: :cascade
  add_foreign_key "sales_note_part", "sales_note", name: "sales_note_part_sales_note_sales_note_id", on_delete: :cascade
  add_foreign_key "sales_note_part", "user", column: "create_uid", name: "sales_note_part_user_create_uid"
  add_foreign_key "sales_note_part", "user", column: "write_uid", name: "sales_note_part_user_write_uid"
  add_foreign_key "standard_bearing_spacer", "bearing_spacer", column: "oversized_part_id", primary_key: "part_id", name: "standard_bearing_spacer_ibfk_2"
  add_foreign_key "standard_bearing_spacer", "bearing_spacer", column: "standard_part_id", primary_key: "part_id", name: "standard_bearing_spacer_ibfk_1"
  add_foreign_key "standard_journal_bearing", "journal_bearing", column: "oversized_part_id", primary_key: "part_id", name: "standard_journal_bearing_ibfk_2"
  add_foreign_key "standard_journal_bearing", "journal_bearing", column: "standard_part_id", primary_key: "part_id", name: "standard_journal_bearing_ibfk_1"
  add_foreign_key "standard_oversize_part", "part", column: "oversize_part_id", name: "standard_oversize_part_oversized_part_id", on_delete: :cascade
  add_foreign_key "standard_oversize_part", "part", column: "standard_part_id", name: "standard_oversize_part_standard_part_id", on_delete: :cascade
  add_foreign_key "turbine_wheel", "part", name: "turbine_wheel_ibfk_1"
  add_foreign_key "turbo", "cool_type", name: "turbo_ibfk_2"
  add_foreign_key "turbo", "part", name: "turbo_ibfk_1"
  add_foreign_key "turbo", "turbo_model", name: "turbo_ibfk_3"
  add_foreign_key "turbo_car_model_engine_year", "car_model_engine_year", name: "turbo_car_model_engine_year_ibfk_1"
  add_foreign_key "turbo_car_model_engine_year", "turbo", column: "part_id", primary_key: "part_id", name: "turbo_car_model_engine_year_ibfk_2"
  add_foreign_key "turbo_model", "turbo_type", name: "turbo_model_ibfk_1"
  add_foreign_key "turbo_type", "manfr", name: "turbo_type_ibfk_1"
  add_foreign_key "user_group", "groups", name: "user_group_ibfk_2"
  add_foreign_key "user_group", "user", name: "user_group_ibfk_1"
end
