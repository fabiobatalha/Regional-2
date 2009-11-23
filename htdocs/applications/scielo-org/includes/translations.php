<?
$langs = array("pt","en","es");
if(!in_array($lang,$langs)){
    $lang = "en";
}

if($lang == "pt"){
    /*
     * User Shelf
     */
    define("ENABLE_CITED_ALERTS_OK","Serviço de citações habilitado.");
    define("ENABLE_ACCESS_ALERT_OK","Serviço de estatísticas de acesso habilitado.");
    define("TRY_AGAIN_LATER","Serviço temporariamente indisponível, tente novamente mais tarde.");
    define("ADD_TO_SHELF_OK","artigo adicionado a sua coleção");
    define("SERVICE_UNAVAILABLE","serviço temporariamente indisponível, tente novamente mais tarde");

    /*
     * Login Form
     */
    define("FREE_REGISTRATION","Registre-se Gratuitamente!");
    define("FREE_REGISRATION_DESC","Para oferecer serviços personalizados, identificando seu perfil, o novo Portal SciELO pede para o usuário que faça seu registro pessoal. O registro no Portal SciELO é gratuito, ao fazer-lo você poderá utilizar os serviços personalizados em quaquer instância SciELO.");
    define("LEARN_MORE","saiba mais");

    /*
     * Textos
     */
    define("HOME","home");
    define("SEARCH_JOURNALS","Pesquisa por Títulos");
    define("JOURNALS_ALPHABETIC_LIST","Títulos em alfabética");

    /*
     * Related and Cited
     */
    define("SIMILARS_IN","Similares em");
    define("CITED_BY","Citado por");


    /*
    segundo nivel SciELO em números
    */
    define("NUMBERS","SciELO em números");
    define("CITATION","Citações");
    define("CO_AUTHORS","Co-autoria");
    define("USAGE","Uso do site");
    define("BRASIL","Brasil");
    define("CHILE","Chile");
    define("CUBA","Cuba");
    define("PUBLIC_HEALTH","Saúde Pública");
    define("SPAIN","Espanha");
    define("VENEZUELA","Venezuela");

    /*
    pesquisa por titulos
    */
    define("FIND_RESULTS","resultados encontrados :");
    define("OCCURRENCE","Ocorrência(s)");
    define("SEARCH_JOURNALS","Pesquisa de Títulos");
    define("ALL","Todos");

    /*
    Collexis Instances Name
    */
    define("ARR","SCI_OVERALL|SciELO Regional,SCI_SCIELOBR|SciELO Brasil,SCI_SCIELOCL|SciELO Chile,SCI_SCIELOCB|SciELO Cuba,SCI_SCIELOESP| SciELO Espanha,SCI_SCIELOVE|SciELO Venezuela,SCI_SCIELOSP|SciELO Saúde Pública,SCI_SCIELOSS|SciELO Ciências Sociais");
    define("FULL_TEXT","texto completo");
    define("SIMILARITY","Relevância");
    define("SEARCHING_IN","Pesquisando em");

}if ($lang=="en"){
    /*
     * User Shelf
     */
    define("ENABLE_CITED_ALERTS_OK","Citation services enable.");
    define("ENABLE_ACCESS_ALERT_OK","Access statistics services enable.");
    define("TRY_AGAIN_LATER","Service temporary unavailable, try again later.");
    define("ADD_TO_SHELF_OK","Article added in your collection");
    define("SERVICE_UNAVAILABLE","Services temporari unavailable, try again later.");

    /*
     * Login Form
     */
    define("FREE_REGISTRATION","Free sign up!");
    define("FREE_REGISRATION_DESC","To offer personalized services to users, by identifying your interests profile, the new SciELO Portal requests the users for registering. The registration in SciELO Portal is completely free, and you'll be able to log-in and use your personal services at any instance of SciELO.");
    define("LEARN_MORE","learn more");

    /*
     * textos
     */
    define("HOME","home");
    define("SEARCH_JOURNALS","Search Journals");
    define("JOURNALS_ALPHABETIC_LIST","Jounals by alphabetic list");


    /*
     * Related and Cited
     */
    define("SIMILARS_IN","Similars in");
    define("CITED_BY","Cited by");

    /*
    segundo nivel SciELO em números
    */
    define("NUMBERS","SciELO in numbers");
    define("CITATION","Citations");
    define("CO_AUTHORS","Co-authors");
    define("USAGE","Site usage");
    define("BRASIL","Brasil");
    define("CHILE","Chile");
    define("CUBA","Cuba");
    define("PUBLIC_HEALTH","Public Health");
    define("SPAIN","Spain");
    define("VENEZUELA","Venezuela");

    /*
    pesquisa por titulos
    */
    define("FIND_RESULTS","results :");
    define("OCCURRENCE","Occurrence(s)");
    define("SEARCH_JOURNALS","Search Journals");
    define("ALL","All");

    /*
    Collexis Instances Name
    */
    define("ARR","SCI_OVERALL|SciELO Regional,SCI_SCIELOBR|SciELO Brazil,SCI_SCIELOCL|SciELO Chile,SCI_SCIELOCB|SciELO Cuba,SCI_SCIELOESP| SciELO Spain,SCI_SCIELOVE|SciELO Venezuela,SCI_SCIELOSP|SciELO Public Health,SCI_SCIELOSS|SciELO Social Sciences");
    define("FULL_TEXT","full text");
    define("SIMILARITY","Similarity");
    define("SEARCHING_IN","Searching in");
}
if ($lang=="es"){
    /*
     * User Shelf
     */
    define("ENABLE_CITED_ALERTS_OK","Servicios de citaciones habilitado.");
    define("ENABLE_ACCESS_ALERT_OK","Servicios de estadísticas de acceso habilitado.");
    define("TRY_AGAIN_LATER","Servicio indiponivel, tente nuevamiente mas tarte.");
    define("ADD_TO_SHELF_OK","Artículo añadido en su colección");
    define("SERVICE_UNAVAILABLE","Servicio temporariamente indisponivel, tente nuevamente mas tarde.");

    /*
     * Login Form
     */
    define("FREE_REGISTRATION","¡Registrese Gratuitamente!");
    define("FREE_REGISRATION_DESC","El nuevo portal SciELO ofrece servicios personalizados. Para acceder a ellos ha de registrarse y completar los datos relativos a su perfil. Este registro es gratuito y le permitirá acceder a los servicios personalizados de cualquier colección SciELO.");
    define("LEARN_MORE","sepa mas");

    /*
    textos
    */
    define("HOME","home");
    define("SEARCH_JOURNALS","Búsqueda por Periódicos");
    define("JOURNALS_ALPHABETIC_LIST","Periódicos en orden alfabética");

    /*
     * Related and Cited
     */
    define("SIMILARS_IN","Similares en");
    define("CITED_BY","Citado por");

    /*
    segundo nivel SciELO em números
    */
    define("NUMBERS","SciELO en números");
    define("CITATION","Citas de revistas");
    define("CO_AUTHORS","Co-autoria");
    define("USAGE","Uso del sitio");
    define("BRASIL","Brasil");
    define("CHILE","Chile");
    define("CUBA","Cuba");
    define("PUBLIC_HEALTH","Salud Pública");
    define("SPAIN","España");
    define("VENEZUELA","Venezuela");

    /*
    pesquisa por titulos
    */
    define("FIND_RESULTS","resultados encontrados :");
    define("OCCURRENCE","Ocurrencia(s)");
    define("SEARCH_JOURNALS","Búsqueda de Periódicos");
    define("ALL","Todos");

    /*
    Collexis Instances Name
    */
    define("ARR","SCI_OVERALL|SciELO Regional,SCI_SCIELOBR|SciELO Brasil,SCI_SCIELOCL|SciELO Chile,SCI_SCIELOCB|SciELO Cuba,SCI_SCIELOESP| SciELO España,SCI_SCIELOVE|SciELO Venezuela,SCI_SCIELOSP|SciELO Salud Pública,SCI_SCIELOSS|SciELO Ciências Sociales");
    define("FULL_TEXT","texto completo");
    define("DESCRIPTION_TITLE","");
    define("SIMILARITY","Relevancia");
    define("SEARCHING_IN","Pesquisando en");
}
?>
