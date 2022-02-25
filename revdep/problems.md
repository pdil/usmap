# ecocomDP

<details>

* Version: 1.2.0
* GitHub: https://github.com/EDIorg/ecocomDP
* Source code: https://github.com/cran/ecocomDP
* Date/Publication: 2021-10-18 22:50:05 UTC
* Number of recursive dependencies: 155

Run `revdep_details(, "ecocomDP")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    Running examples in ‘ecocomDP-Ex.R’ failed
    The error most likely occurred in:
    
    > ### Name: plot_sites
    > ### Title: Plot sites on US map
    > ### Aliases: plot_sites
    > 
    > ### ** Examples
    > 
    > ## Not run: 
    ...
    > ##D   flatten_data() %>% 
    > ##D   plot_sites()
    > ## End(Not run)
    > 
    > # Plot the example dataset
    > plot_sites(ants_L1)
    Error in usmap_transform.data.frame(cleaned) : 
      All `input_names` must exist as column names in `data`.
    Calls: plot_sites
    Execution halted
    ```

