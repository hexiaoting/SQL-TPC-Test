CREATE EXTERNAL TABLE NATION  ( N_NATIONKEY  INTEGER ,
                            N_NAME      STRING ,
                            N_REGIONKEY  INTEGER ,
                            N_COMMENT    VARCHAR(152))stored as parquet location "hdfs://dell127:20500/SparkParquetDoubleTimestamp100G/nation/";

CREATE EXTERNAL TABLE REGION  ( R_REGIONKEY  INTEGER ,
                            R_NAME      STRING ,
                            R_COMMENT    VARCHAR(152))stored as parquet location "hdfs://dell127:20500/SparkParquetDoubleTimestamp100G/region/";

CREATE EXTERNAL TABLE PART  ( P_PARTKEY     INTEGER ,
                          P_NAME        VARCHAR(55) ,
                          P_MFGR       STRING ,
                          P_BRAND      STRING ,
                          P_TYPE        VARCHAR(25) ,
                          P_SIZE        INTEGER ,
                          P_CONTAINER  STRING ,
                          P_RETAILPRICE DOUBLE ,
                          P_COMMENT     VARCHAR(23)  )stored as parquet location "hdfs://dell127:20500/SparkParquetDoubleTimestamp100G/part/";

CREATE EXTERNAL TABLE SUPPLIER ( S_SUPPKEY     INTEGER ,
                             S_NAME       STRING ,
                             S_ADDRESS     VARCHAR(40) ,
                             S_NATIONKEY   INTEGER ,
                             S_PHONE      STRING ,
                             S_ACCTBAL     DOUBLE ,
                             S_COMMENT     VARCHAR(101) )stored as parquet location "hdfs://dell127:20500/SparkParquetDoubleTimestamp100G/supplier/";

CREATE EXTERNAL TABLE PARTSUPP ( PS_PARTKEY     INTEGER ,
                             PS_SUPPKEY     INTEGER ,
                             PS_AVAILQTY    INTEGER ,
                             PS_SUPPLYCOST  DOUBLE  ,
                             PS_COMMENT     VARCHAR(199)  )stored as parquet location "hdfs://dell127:20500/SparkParquetDoubleTimestamp100G/partsupp/";

CREATE EXTERNAL TABLE CUSTOMER ( C_CUSTKEY     INTEGER ,
                             C_NAME        VARCHAR(25) ,
                             C_ADDRESS     VARCHAR(40) ,
                             C_NATIONKEY   INTEGER ,
                             C_PHONE      STRING ,
                             C_ACCTBAL     DOUBLE   ,
                             C_MKTSEGMENT STRING ,
                             C_COMMENT     VARCHAR(117) )stored as parquet location "hdfs://dell127:20500/SparkParquetDoubleTimestamp100G/customer/";

CREATE EXTERNAL TABLE ORDERS  ( O_ORDERKEY       INTEGER ,
                           O_CUSTKEY        INTEGER ,
                           O_ORDERSTATUS   STRING ,
                           O_TOTALPRICE     DOUBLE ,
                           O_ORDERDATE      TIMESTAMP ,
                           O_ORDERPRIORITY STRING ,
                           O_CLERK         STRING ,
                           O_SHIPPRIORITY   INTEGER ,
                           O_COMMENT        VARCHAR(79) )stored as parquet location "hdfs://dell127:20500/SparkParquetDoubleTimestamp100G/orders/";

CREATE EXTERNAL TABLE LINEITEM ( L_ORDERKEY    INTEGER ,
                             L_PARTKEY     INTEGER ,
                             L_SUPPKEY     INTEGER ,
                             L_LINENUMBER  INTEGER ,
                             L_QUANTITY    DOUBLE ,
                             L_EXTENDEDPRICE  DOUBLE ,
                             L_DISCOUNT    DOUBLE ,
                             L_TAX         DOUBLE ,
                             L_RETURNFLAG STRING ,
                             L_LINESTATUS STRING ,
                             L_SHIPDATE    TIMESTAMP ,
                             L_COMMITDATE  TIMESTAMP ,
                             L_RECEIPTDATE TIMESTAMP ,
                             L_SHIPINSTRUCT STRING ,
                             L_SHIPMODE    STRING ,
                             L_COMMENT      VARCHAR(44) )stored as parquet location "hdfs://dell127:20500/SparkParquetDoubleTimestamp100G/lineitem/";

