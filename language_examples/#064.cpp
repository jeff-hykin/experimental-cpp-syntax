void function() {
    int *a = ::new int;
    int *a = new int;
    int *a = ::new[] int;
    int *a = new[] int;
    int *a = ::new (int);
    int *a = new (int);
    int *a = ::new[] (int);
    int *a = new[] (int);
    int *a = ::new(2, f) int;
    int *a = new(2, f) int;
    int *a = ::new(2, f)[] int;
    int *a = new(2, f)[] int;
    int *a = ::new(2, f) (int);
    int *a = new(2, f) (int);
    int *a = ::new(2, f)[] (int);
    int *a = new(2, f)[] (int);
    ::delete a;
    delete a;
    ::delete[] a;
    delete[] a;
    ::delete (a);
    delete (a);
    ::delete[] (a);
    delete[] (a);
    ::delete (a, b);
    delete (a, b);
    ::delete[] (a, b);
    delete[] (a, b);
}