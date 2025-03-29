ALTER TABLE products
ADD CONSTRAINT chk_product_id CHECK(product_id >=0);