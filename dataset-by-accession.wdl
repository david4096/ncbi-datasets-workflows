version 1.0
# Task to download genome data using the datasets CLI
task download_genome_data {
    input {
        String accession  # Input: Accession ID for the genome
    }

    command <<<
        datasets download genome accession ~{accession} --dehydrated --filename ~{accession}.zip
    >>>

    output {
        File downloaded_genome = "${accession}.zip"  # Output: Downloaded genome data file
    }

    runtime {
        docker: "david4096/ncbi-datasets:latest"  # Use the specified Docker image
    }
}

# Workflow to run the download task
workflow DatasetByAccession {
    input {
        String accession  # Input: Accession ID for the genome
    }

    call download_genome_data {
        input:
            accession = accession
    }

    output {
        File downloaded_genome = download_genome_data.downloaded_genome
    }
}
