#include "qwseditor.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    qWSEditor w;
    w.show();
    return a.exec();
}
