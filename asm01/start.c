int
start()
{
    int b=0;
    for(int i = 0; i <= 10; i++)
    {
        b *= i + b;
    }

    return b;
}