
use supplychain;

ALTER TABLE supply_chain_data
RENAME COLUMN `Product type` TO product_type,
RENAME COLUMN `SKU` TO sku,
RENAME COLUMN `Price` TO price,
RENAME COLUMN `Availability` TO availability,
RENAME COLUMN `Number of products sold` TO number_of_products_sold,
RENAME COLUMN `Revenue generated` TO revenue_generated,
RENAME COLUMN `Customer demographics` TO customer_demographics,
RENAME COLUMN `Stock levels` TO stock_levels,
RENAME COLUMN `Lead times` TO lead_times,
RENAME COLUMN `Order quantities` TO order_quantities,
RENAME COLUMN `Shipping times` TO shipping_times,
RENAME COLUMN `Shipping carriers` TO shipping_carriers,
RENAME COLUMN `Shipping costs` TO shipping_costs,
RENAME COLUMN `Supplier name` TO supplier_name,
RENAME COLUMN `Location` TO location,
RENAME COLUMN `Lead time` TO lead_time,
RENAME COLUMN `Production volumes` TO production_volumes,
RENAME COLUMN `Manufacturing lead time` TO manufacturing_lead_time,
RENAME COLUMN `Manufacturing costs` TO manufacturing_costs,
RENAME COLUMN `Inspection results` TO inspection_results,
RENAME COLUMN `Defect rates` TO defect_rates,
RENAME COLUMN `Transportation modes` TO transportation_modes,
RENAME COLUMN `Routes` TO routes,
RENAME COLUMN `Costs` TO costs;

SELECT *
from supply_chain_data;

-- Which product type generates the most revenue?
SELECT 
    `Product type`,
    SUM(`Revenue generated`) AS total_revenue
FROM supply_chain_data
GROUP BY `Product type`
ORDER BY total_revenue DESC;

-- el producto mas vendido
SELECT SKU,`Product type`,`Number of products sold`
FROM supply_chain_data
ORDER BY `Number of products sold` DESC
LIMIT 1;
-- el producto menos vendido
SELECT SKU,`Product type`,`Number of products sold`
FROM supply_chain_data
ORDER BY `Number of products sold` ASC
LIMIT 1;
-- ventas mayores que el stock disponible.
SELECT sku,stock_levels,number_of_products_sold
FROM supply_chain_data
WHERE stock_levels < number_of_products_sold
ORDER BY number_of_products_sold DESC;
-- Which transportation mode (Road, Air, Rail) is fastest vs. most cost-effective?
SELECT transportation_modes, AVG(shipping_times) AS avg_shipping_time
FROM supply_chain_data
GROUP BY transportation_modes
ORDER BY avg_shipping_time ASC;
-- Most cost-effective transportation mode (menor costo promedio)
SELECT transportation_modes, AVG(costs) AS avg_transport_cost
FROM supply_chain_data
GROUP BY transportation_modes
ORDER BY avg_transport_cost ASC;
-- comparar velocidad vs costo en una sola consulta
SELECT transportation_modes, AVG(shipping_times) AS avg_shipping_time, AVG(costs) AS avg_transport_cost
FROM supply_chain_data
GROUP BY transportation_modes
ORDER BY avg_shipping_time;
-- Which supplier has the shortest lead time?
SELECT supplier_name, AVG(lead_time) AS avg_lead_time
FROM supply_chain_data
GROUP BY supplier_name
ORDER BY avg_lead_time ASC
LIMIT 1;
-- Which location has the highest production volumes?
SELECT location, SUM(production_volumes) AS total_production
FROM supply_chain_data
GROUP BY location
ORDER BY total_production DESC
LIMIT 1;
-- How do manufacturing costs vary across suppliers?
SELECT supplier_name, AVG(manufacturing_costs) AS avg_manufacturing_cost
FROM supply_chain_data
GROUP BY supplier_name
ORDER BY avg_manufacturing_cost DESC;
-- Which supplier has the highest defect rates?
SELECT supplier_name, AVG(defect_rates) AS avg_defect_rate
FROM supply_chain_data
GROUP BY supplier_name
ORDER BY avg_defect_rate DESC
LIMIT 1;
-- ¿Cuál es el precio promedio por tipo de producto?
SELECT product_type, AVG(unit_cost) AS total_avg
FROM supply_chain_data
GROUP BY product_type
ORDER BY total_avg;
