Archivos JSON
================

## Leer JSON

Para leer archivos JSON utilizaremos el paquete jsonlite.

Podemos leer directamente de un archivo que esté en Internet, por
ejemplo, el que contiene la información de Github de los repositorios
que tengo y participo.

``` r
library(jsonlite)
jsondata <- fromJSON("https://api.github.com/users/carlosguadian/repos")
names(jsondata) # acceso a los diferentes elementos que conformarían el dataframe
```

    ##  [1] "id"                "node_id"           "name"             
    ##  [4] "full_name"         "private"           "owner"            
    ##  [7] "html_url"          "description"       "fork"             
    ## [10] "url"               "forks_url"         "keys_url"         
    ## [13] "collaborators_url" "teams_url"         "hooks_url"        
    ## [16] "issue_events_url"  "events_url"        "assignees_url"    
    ## [19] "branches_url"      "tags_url"          "blobs_url"        
    ## [22] "git_tags_url"      "git_refs_url"      "trees_url"        
    ## [25] "statuses_url"      "languages_url"     "stargazers_url"   
    ## [28] "contributors_url"  "subscribers_url"   "subscription_url" 
    ## [31] "commits_url"       "git_commits_url"   "comments_url"     
    ## [34] "issue_comment_url" "contents_url"      "compare_url"      
    ## [37] "merges_url"        "archive_url"       "downloads_url"    
    ## [40] "issues_url"        "pulls_url"         "milestones_url"   
    ## [43] "notifications_url" "labels_url"        "releases_url"     
    ## [46] "deployments_url"   "created_at"        "updated_at"       
    ## [49] "pushed_at"         "git_url"           "ssh_url"          
    ## [52] "clone_url"         "svn_url"           "homepage"         
    ## [55] "size"              "stargazers_count"  "watchers_count"   
    ## [58] "language"          "has_issues"        "has_projects"     
    ## [61] "has_downloads"     "has_wiki"          "has_pages"        
    ## [64] "forks_count"       "mirror_url"        "archived"         
    ## [67] "disabled"          "open_issues_count" "license"          
    ## [70] "allow_forking"     "forks"             "open_issues"      
    ## [73] "watchers"          "default_branch"

``` r
names(jsondata$owner) # se puede acceder a uno específico
```

    ##  [1] "login"               "id"                  "node_id"            
    ##  [4] "avatar_url"          "gravatar_id"         "url"                
    ##  [7] "html_url"            "followers_url"       "following_url"      
    ## [10] "gists_url"           "starred_url"         "subscriptions_url"  
    ## [13] "organizations_url"   "repos_url"           "events_url"         
    ## [16] "received_events_url" "type"                "site_admin"

``` r
jsondata$owner$login # incluso bajar un nivel más
```

    ##  [1] "carlosguadian" "carlosguadian" "carlosguadian" "carlosguadian"
    ##  [5] "carlosguadian" "carlosguadian" "carlosguadian" "carlosguadian"
    ##  [9] "carlosguadian" "carlosguadian" "carlosguadian" "carlosguadian"
    ## [13] "carlosguadian" "carlosguadian" "carlosguadian"

Con este paquete también se puede convertir un dataframe en json.
Probemos con Iris data.

``` r
myjson <- toJSON(iris, pretty = TRUE)
# cat(myjson)
```

Y lo podemos volver a dataframe con fromJSON

``` r
iris2 <- fromJSON(myjson)
head(iris2)
```

    ##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ## 1          5.1         3.5          1.4         0.2  setosa
    ## 2          4.9         3.0          1.4         0.2  setosa
    ## 3          4.7         3.2          1.3         0.2  setosa
    ## 4          4.6         3.1          1.5         0.2  setosa
    ## 5          5.0         3.6          1.4         0.2  setosa
    ## 6          5.4         3.9          1.7         0.4  setosa
