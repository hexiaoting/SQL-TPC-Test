package main.scala

import org.apache.spark.SparkContext
import org.apache.spark.sql.SparkSession

// TPC-H table schemas
case class Customer(
  c_custkey: Int,
  c_name: String,
  c_address: String,
  c_nationkey: Int,
  c_phone: String,
  c_acctbal: Double,
  c_mktsegment: String,
  c_comment: String)

case class Lineitem(
  l_orderkey: Int,
  l_partkey: Int,
  l_suppkey: Int,
  l_linenumber: Int,
  l_quantity: Double,
  l_extendedprice: Double,
  l_discount: Double,
  l_tax: Double,
  l_returnflag: String,
  l_linestatus: String,
  l_shipdate: String,
  l_commitdate: String,
  l_receiptdate: String,
  l_shipinstruct: String,
  l_shipmode: String,
  l_comment: String)

case class Nation(
  n_nationkey: Int,
  n_name: String,
  n_regionkey: Int,
  n_comment: String)

case class Order(
  o_orderkey: Int,
  o_custkey: Int,
  o_orderstatus: String,
  o_totalprice: Double,
  o_orderdate: String,
  o_orderpriority: String,
  o_clerk: String,
  o_shippriority: Int,
  o_comment: String)

case class Part(
  p_partkey: Int,
  p_name: String,
  p_mfgr: String,
  p_brand: String,
  p_type: String,
  p_size: Int,
  p_container: String,
  p_retailprice: Double,
  p_comment: String)

case class Partsupp(
  ps_partkey: Int,
  ps_suppkey: Int,
  ps_availqty: Int,
  ps_supplycost: Double,
  ps_comment: String)

case class Region(
  r_regionkey: Int,
  r_name: String,
  r_comment: String)

case class Supplier(
  s_suppkey: Int,
  s_name: String,
  s_address: String,
  s_nationkey: Int,
  s_phone: String,
  s_acctbal: Double,
  s_comment: String)

class TpchSchemaProvider(inputDir: String) {
  val spark = SparkSession.builder().appName("TpchQuery").getOrCreate()
  import spark.implicits._
  val customer = spark.read.parquet(inputDir + "/customer")
  val lineitem = spark.read.parquet(inputDir + "/lineitem")
  val nation = spark.read.parquet(inputDir + "/nation")
  val region = spark.read.parquet(inputDir + "/region")
  val order = spark.read.parquet(inputDir + "/orders")
  val part = spark.read.parquet(inputDir + "/part")
  val partsupp = spark.read.parquet(inputDir + "/partsupp")
  val supplier = spark.read.parquet(inputDir + "/supplier")
}
