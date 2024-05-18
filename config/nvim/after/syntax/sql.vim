syn keyword sqlSpecail contained false null true

syn match   sqlVariable     "&\a\w\+"
syn match   sqlVariable     ":\w\+"
syn match   sqlVariable     "SQL%\w\+"

syn match sqlOperator contained "\%(<->>>\|<<->>\|<<<->\|!\~\~\*\|\#<=\#\|\#>=\#\|<->>\|<<->\|\~<=\~\|\~>=\~\|!\~\*\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"
syn match sqlOperator contained "\%(!\~\~\|\#<\#\|\#>\#\|\#>>\|%>>\|&&&\|&/&\|&<|\|\*<=\|\*<>\|\*>=\|->>\|-|-\|<\#>\|<->\|<<%\|<<=\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"
syn match sqlOperator contained "\%(<<@\|<<|\|<=>\|<@>\|>>=\|?-|\|?<@\|?@>\|?||\|@-@\|@>>\|@@@\|\^<@\|\^@>\||&>\||=|\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"
syn match sqlOperator contained "\%(|>>\|||/\|\~<\~\|\~==\|\~>\~\|\~\~\*\|\~\~=\|!!\|!\~\|\#\#\|\#-\|\#=\|\#>\|%\#\|%%\|%>\|&&\|&<\|&>\|\*<\|\*=\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"
syn match sqlOperator contained "\%(\*>\|->\|<%\|<<\|<=\|<>\|<@\|<\^\|=>\|>=\|>>\|>\^\|?\#\|?&\|?-\|?@\|?|\|?\~\|@>\|@?\|@@\|\^?\|\^@\|\^\~\||/\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"
syn match sqlOperator contained "\%(||\|\~\*\|\~=\|\~>\|\~\~\|\#\|%\|&\|\*\|+\|-\|/\|<\|=\|>\|?\|@\|\^\||\|\~\)\ze\%([^!?~#^@<=>%&|*/+-]\|$\)"

syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\[aCfHhortTxz]\>\|\\[?!]/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\c\%(\%(d\|onnect\|onninfo\|opy\%(right\)\?\|rosstabview\)\?\)\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\d\>\|\\dS\>+\?\|\\d[ao]S\?\>\|\\d[cDgiLmnOstTuvE]\%(\>\|S\>+\?\)/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\d[AbClx]\>+\?\|\\d[py]\>\|\\dd[pS]\>\?\|\\de[tsuw]\>+\?\|\\df[antw]\?S\?\>+\?\|\\dF[dpt]\?\>+\?\|\\drds\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\e\%(cho\|[fv]\|ncoding\|rrverbose\)\?\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\g\%(exec\|set\)\?\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\ir\?\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\l\>+\?\|\\lo_\%(export\|import\|list\|unlink\)\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\p\%(assword\|rompt\|set\)\?\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\q\%(echo\)\?\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\s\>\|\\s[fv]\>+\?\|\\set\%(env\)\?\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\t\%(iming\)\?\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\unset\>/
syn match sqlKeyword contained nextgroup=sqlPsqlKeyword,sqlNumber,sqlString /\\w\%(atch\)\?\>/

syn keyword sqlStatement contained abort add alter analyze begin checkpoint close cluster comment
syn keyword sqlStatement contained commit constraints copy deallocate declare delete discard do drop end
syn keyword sqlStatement contained execute explain fetch grant import insert label listen load lock move
syn keyword sqlStatement contained notify prepare prepared reassign refresh reindex release reset revoke
syn keyword sqlStatement contained rollback savepoint security select select set show start transaction
syn keyword sqlStatement contained truncate unlisten update vacuum values work create replace

syn keyword sqlFunction contained count sum avg min max distinct upper lower length substring 
syn keyword sqlFunction contained rim coalesce nullif round ceiling floor power sqrt abs exp log log10 sin cos tan asin acos 
syn keyword sqlFunction contained tan degrees radians to_hex hex date time timestamp extract date_add date_sub now curdate 
syn keyword sqlFunction contained urtime year month day hour minute second concat concat_ws left right replace lpad rpad 
syn keyword sqlFunction contained trim rtrim position char_length octet_length to_char to_number 
syn keyword sqlFunction contained o_date cast convert nvl decode case ifnull isnull nvl2
syn keyword sqlFunction contained uuid_generate_v1 uuid_generate_v1mc
syn keyword sqlFunction contained uuid_generate_v3 uuid_generate_v4 uuid_generate_v5
syn keyword sqlFunction contained uuid_nil uuid_ns_dns uuid_ns_oid
syn keyword sqlFunction contained uuid_ns_url uuid_ns_x500
syn keyword sqlFunction contained armor crypt dearmor decrypt
syn keyword sqlFunction contained decrypt_iv digest encrypt encrypt_iv
syn keyword sqlFunction contained gen_random_bytes gen_random_uuid gen_salt
syn keyword sqlFunction contained hmac pgp_armor_headers pgp_key_id
syn keyword sqlFunction contained pgp_pub_decrypt pgp_pub_decrypt_bytea
syn keyword sqlFunction contained pgp_pub_encrypt pgp_pub_encrypt_bytea pgp_sym_decrypt
syn keyword sqlFunction contained pgp_sym_decrypt_bytea pgp_sym_encrypt
syn keyword sqlFunction contained pgp_sym_encrypt_bytea

syn keyword sqlType contained aclitem addbandarg addr addrfeat agg_count agg_samealignment
syn keyword sqlType contained anyarray anycompatible anycompatiblearray anycompatiblemultirange
syn keyword sqlType contained anycompatiblenonarray anycompatiblerange anyelement anyenum
syn keyword sqlType contained anymultirange anynonarray anyrange bg bit bool box box2d box2df box3d
syn keyword sqlType contained bpchar bytea cardinal_number char character_data cid cidr circle
syn keyword sqlType contained citext county county_lookup countysub_lookup cousub cstring cube date
syn keyword sqlType contained datemultirange daterange dblink_pkey_results direction_lookup
syn keyword sqlType contained ean13 earth edges errcodes event_trigger faces fdw_handler featnames
syn keyword sqlType contained float4 float8 gbtreekey16 gbtreekey32 gbtreekey4 gbtreekey8
syn keyword sqlType contained gbtreekey_var geocode_settings geocode_settings_default geography
syn keyword sqlType contained geography_columns geometry geometry_columns geometry_dump geomval
syn keyword sqlType contained getfaceedges_returntype ghstore gidx gtrgm gtsvector hstore
syn keyword sqlType contained index_am_handler inet int2 int2vector int4 int4multirange int4range
syn keyword sqlType contained int8 int8multirange int8range intbig_gkey internal interval isbn
syn keyword sqlType contained isbn13 ismn ismn13 issn issn13 json jsonb jsonpath language_handler
syn keyword sqlType contained layer line lo loader_lookuptables loader_platform loader_variables
syn keyword sqlType contained lquery lseg ltree ltree_gist ltxtquery macaddr macaddr8 money
syn keyword sqlType contained norm_addy numeric nummultirange numrange oid oidvector pagc_gaz pagc_lex
syn keyword sqlType contained pagc_rules path pg_all_foreign_keys pg_brin_bloom_summary
syn keyword sqlType contained pg_brin_minmax_multi_summary pg_ddl_command pg_dependencies pg_lsn
syn keyword sqlType contained pg_mcv_list pg_ndistinct pg_node_tree pg_snapshot
syn keyword sqlType contained pg_stat_statements_info place place_lookup point polygon query_int rastbandarg
syn keyword sqlType contained raster raster_columns raster_overviews reclassarg record refcursor
syn keyword sqlType contained regclass regcollation regconfig regdictionary regnamespace
syn keyword sqlType contained regoper regoperator regproc regprocedure regrole regtype
syn keyword sqlType contained secondary_unit_lookup seg spatial_ref_sys spheroid sql_identifier state
syn keyword sqlType contained state_lookup stdaddr street_type_lookup summarystats tabblock
syn keyword sqlType contained tabblock20 table_am_handler tablefunc_crosstab_2 tablefunc_crosstab_3
syn keyword sqlType contained tablefunc_crosstab_4 tap_funky text tid time time_stamp timestamp
syn keyword sqlType contained timestamptz timetz topoelement topoelementarray topogeometry
syn keyword sqlType contained topology tract tsm_handler tsmultirange tsquery tsrange
syn keyword sqlType contained tstzmultirange tstzrange tsvector txid_snapshot unionarg upc us_gaz us_lex
syn keyword sqlType contained us_rules uuid valid_detail validatetopology_returntype varbit varchar
syn keyword sqlType contained void xid xid8 xml yes_or_no zcta5 zip_lookup zip_lookup_all
syn keyword sqlType contained zip_lookup_base zip_state zip_state_loc 

syn keyword sqlKeyword contained absolute access action admin after aggregate all also always
syn keyword sqlKeyword contained analyse and any as asc asensitive assertion assignment asymmetric atomic
syn keyword sqlKeyword contained attach attribute authorization backward basetype before between
syn keyword sqlKeyword contained binary both breadth by bypassrls cache call called cascade cascaded case
syn keyword sqlKeyword contained cast catalog century chain characteristics check class coalesce
syn keyword sqlKeyword contained collate collation column columns combinefunc comments committed
syn keyword sqlKeyword contained compression concurrently configuration conflict connection constraint
syn keyword sqlKeyword contained content continue conversion cost createdb createrole cross csv
syn keyword sqlKeyword contained current current_catalog current_date current_role current_schema
syn keyword sqlKeyword contained current_time current_timestamp current_user cursor cycle data
syn keyword sqlKeyword contained database day dec decade default defaults deferrable deferred definer
syn keyword sqlKeyword contained delimiter delimiters depends depth desc deserialfunc detach dictionary
syn keyword sqlKeyword contained disable distinct document domain dow doy each else enable encoding
syn keyword sqlKeyword contained encrypted enum epoch escape event except exclude excluding exclusive
syn keyword sqlKeyword contained exists expression extension external extract false family filter
syn keyword sqlKeyword contained finalfunc finalfunc_extra finalfunc_modify finalize first float
syn keyword sqlKeyword contained following for force foreign forward freeze from full function functions
syn keyword sqlKeyword contained generated global granted greatest group grouping groups handler having
syn keyword sqlKeyword contained header hold hour hypothetical identity if ilike immediate immutable
syn keyword sqlKeyword contained implicit in include including increment index indexes inherit
syn keyword sqlKeyword contained inherits initcond initially inline inner inout input insensitive instead
syn keyword sqlKeyword contained intersect into invoker is isnull isodow isolation isoyear join key
syn keyword sqlKeyword contained language large last lateral lc_collate lc_ctype leading leakproof
syn keyword sqlKeyword contained least left level like limit local locale localtime localtimestamp
syn keyword sqlKeyword contained location locked logged login mapping match materialized maxvalue method
syn keyword sqlKeyword contained mfinalfunc mfinalfunc_extra mfinalfunc_modify microseconds
syn keyword sqlKeyword contained millennium milliseconds minitcond minute minvalue minvfunc mode month
syn keyword sqlKeyword contained msfunc msspace mstype name names national natural nchar new next nfc nfd
syn keyword sqlKeyword contained nfkc nfkd no nobypassrls nocreatedb nocreaterole noinherit nologin
syn keyword sqlKeyword contained none noreplication normalize normalized nosuperuser not nothing
syn keyword sqlKeyword contained notnull nowait null nullif nulls object of off offset oids old on only
syn keyword sqlKeyword contained operator option options or order ordinality others out outer over
syn keyword sqlKeyword contained overlaps overlay overriding owned owner parallel parser partial partition
syn keyword sqlKeyword contained passing password permissive placing plans policy position
syn keyword sqlKeyword contained preceding preserve primary prior privileges procedural procedure
syn keyword sqlKeyword contained procedures program provider public publication quarter quote range read
syn keyword sqlKeyword contained read_write readonly recheck recursive ref references referencing
syn keyword sqlKeyword contained relative rename repeatable replace replica replication restart restrict
syn keyword sqlKeyword contained restricted restrictive return returning returns right role rollup
syn keyword sqlKeyword contained routine routines row rows rule safe schema schemas scroll search second
syn keyword sqlKeyword contained sequence sequences serialfunc serializable server session
syn keyword sqlKeyword contained session_user setof sets sfunc share shareable similar simple skip snapshot
syn keyword sqlKeyword contained some sortop sql sspace stable standalone statement statistics stdin
syn keyword sqlKeyword contained stdout storage stored strict strip stype subscription substring
syn keyword sqlKeyword contained superuser support symmetric sysid system table tables tablesample
syn keyword sqlKeyword contained tablespace temp template temporary then ties timezone timezone_hour
syn keyword sqlKeyword contained timezone_minute to trailing transform treat trigger trim true trusted
syn keyword sqlKeyword contained type types uescape unbounded uncommitted unencrypted union unique
syn keyword sqlKeyword contained unknown unlogged unsafe until usage user using valid validate validator
syn keyword sqlKeyword contained value variadic verbose version view views volatile week when where
syn keyword sqlKeyword contained whitespace window with within without wrapper write xmlattributes
syn keyword sqlKeyword contained xmlconcat xmlelement xmlexists xmlforest xmlnamespaces xmlparse
syn keyword sqlKeyword contained xmlpi xmlroot xmlserialize xmltable year yes
