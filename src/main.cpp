#include "hash_table.h"

int main() {
    size_t amount = 0;
    FILE *fp = fopen("txt/example.txt", "rb");
    FILE *data = fopen("csv/data.csv", "w");

    if (!(fp && data) ) {
        printf ("file doesn't exist\n");
        return 1;
    } 

    char *buffer = read_buffer(fp, &amount);
    table_t table = {};

    table_init(&table, 10000);
    make_table(&table, buffer, amount, crc32);

    double measure = table_dump(&table, data);
    printf("%f\n", measure * 100);
    for (size_t ind = 0; ind < 1000000; ind++) {
        char *word = (char *)"and";
        search(&table, word, hash_first);
    }
    table_destroy(&table);
    free(buffer);
    return 0;
}
