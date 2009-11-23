#declare -x LANG="en_US.ISO-8859-1"
. conf.sh

if [ -f metasearch/proc/generateMetaSearchInstances.sh ]
then 
	if [ -f metasearch/metaSearchInstancesDefinitions.xml ]
	then 
		metasearch/proc/generateMetaSearchInstances.sh pt
		metasearch/proc/generateMetaSearchInstances.sh es
		metasearch/proc/generateMetaSearchInstances.sh en
		cp -rf metasearch/xml/ $HTDOCS/applications/scielo-org/
		cp -rf metasearch/xml/en/*.xml $HTDOCS/applications/scielo-org/xml/en
		cp -rf metasearch/xml/pt/*.xml $HTDOCS/applications/scielo-org/xml/pt
		cp -rf metasearch/xml/es/*.xml $HTDOCS/applications/scielo-org/xml/es
	fi
fi
