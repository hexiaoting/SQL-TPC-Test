import org.apache.spark.sql.SQLContext
import org.apache.spark.SparkContext
import org.apache.spark.SparkContext._
import org.apache.spark.SparkConf
import org.apache.spark.sql.types.{StructType, StructField, StringType,IntegerType,DecimalType,DateType}

object SimpleApp{
	def convert(spark: SQLContext, filename: String, schema: StructType, tablename: String, parquetdir:String) {
		val df = spark.read
			.format("com.databricks.spark.csv")
			.schema(schema)
			.option("delimiter","|")
			.option("treatEmptyValuesAsNulls","true")
			.load(filename)
			df.write.parquet(parquetdir+tablename)
	}
	def main(args: Array[String]) {
		if (args.length != 2) {
			println("<Usage> args: $CsvDir $parquetDir")
			return
		}

		val sc = new SparkContext(new SparkConf().setAppName("CsvToParquet"))
		val spark = new SQLContext(sc)

		val nation_schema = StructType(Array(
			StructField("N_NATIONKEY",  IntegerType, false),
			StructField("N_NAME",       StringType, false),
			StructField("N_REGIONKEY",  IntegerType, false),
			StructField("N_COMMENT",    StringType,true)));

		val region_schema=StructType(Array( StructField("R_REGIONKEY",  IntegerType, false),
			StructField("R_NAME",       StringType, false),
			StructField("R_COMMENT",    StringType,true)));

		val part_schema=StructType(Array( StructField("P_PARTKEY",     IntegerType, false),
			StructField("P_NAME",        StringType, false),
			StructField("P_MFGR",        StringType, false),
			StructField("P_BRAND",       StringType, false),
			StructField("P_TYPE",        StringType, false),
			StructField("P_SIZE",        IntegerType, false),
			StructField("P_CONTAINER",   StringType, false),
			StructField("P_RETAILPRICE", DecimalType(15,2),false),
			StructField("P_COMMENT",     StringType, false) ));

		val supplier_schema=StructType(Array( StructField("S_SUPPKEY",     IntegerType, false),
			StructField("S_NAME",        StringType, false),
			StructField("S_ADDRESS",     StringType, false),
			StructField("S_NATIONKEY",   IntegerType, false),
			StructField("S_PHONE",       StringType, false),
			StructField("S_ACCTBAL",     DecimalType(15,2),false),
			StructField("S_COMMENT",     StringType, false)));

		val partsupp_schema=StructType(Array( StructField("PS_PARTKEY",     IntegerType, false),
			StructField("PS_SUPPKEY",     IntegerType, false),
			StructField("PS_AVAILQTY",    IntegerType, false),
			StructField("PS_SUPPLYCOST",  DecimalType(15,2), false),
			StructField("PS_COMMENT",     StringType, false) ));

		val customer_schema=StructType(Array(
			StructField("C_CUSTKEY",     IntegerType, false),
			StructField("C_NAME",        StringType, false),
			StructField("C_ADDRESS",     StringType, false),
			StructField("C_NATIONKEY",   IntegerType, false),
			StructField("C_PHONE",       StringType, false),
			StructField("C_ACCTBAL",     DecimalType(15,2),  false),
			StructField("C_MKTSEGMENT",  StringType, false),
			StructField("C_COMMENT",     StringType, false)));

		val orders_schema= StructType(Array(
			StructField("O_ORDERKEY",       IntegerType, false),
			StructField("O_CUSTKEY",        IntegerType, false),
			StructField("O_ORDERSTATUS",    StringType, false),
			StructField("O_TOTALPRICE",     DecimalType(15,2),false),
			StructField("O_ORDERDATE",      DateType, false),
			StructField("O_ORDERPRIORITY",  StringType, false),
			StructField("O_CLERK",          StringType, false),
			StructField("O_SHIPPRIORITY",   IntegerType, false),
			StructField("O_COMMENT",        StringType, false)));

		val lineitem_schema= StructType(Array(
			StructField("L_ORDERKEY",    IntegerType, false),
			StructField("L_PARTKEY",     IntegerType, false),
			StructField("L_SUPPKEY",     IntegerType, false),
			StructField("L_LINENUMBER",  IntegerType, false),
			StructField("L_QUANTITY",    DecimalType(15,2),false),
			StructField("L_EXTENDEDPRICE",  DecimalType(15,2),false),
			StructField("L_DISCOUNT",    DecimalType(15,2),false),
			StructField("L_TAX",         DecimalType(15,2),false),
			StructField("L_RETURNFLAG",  StringType, false),
			StructField("L_LINESTATUS",  StringType, false),
			StructField("L_SHIPDATE",    DateType, false),
			StructField("L_COMMITDATE",  DateType, false),
			StructField("L_RECEIPTDATE", DateType, false),
			StructField("L_SHIPINSTRUCT", StringType, false),
			StructField("L_SHIPMODE",     StringType, false),
			StructField("L_COMMENT",      StringType, false)));

		val tableArray=Array("nation", "region","part","supplier","partsupp","customer","orders","lineitem")
		val schemaArray=Array(nation_schema, region_schema,part_schema,
			supplier_schema,partsupp_schema,customer_schema,orders_schema,lineitem_schema)
		for (i <- 0 until tableArray.length)
			convert(spark,args(0)+tableArray(i),schemaArray(i),tableArray(i), args(1));
	}
}
