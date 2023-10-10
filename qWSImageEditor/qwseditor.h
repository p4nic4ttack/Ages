#ifndef QWSEDITOR_H
#define QWSEDITOR_H

#include <QMainWindow>
#include <QColorDialog>
#include <QMessageBox>
#include <settings.h>

QT_BEGIN_NAMESPACE
namespace Ui { class qWSEditor; }
QT_END_NAMESPACE

class qWSEditor : public QMainWindow
{
    Q_OBJECT

public:
    qWSEditor(QWidget *parent = nullptr);
    ~qWSEditor();

private slots:
    void on_col_btn_clicked();

    void on_actionExit_triggered();

    void on_actionEdit_save_settings_triggered();

    void on_save_btn_clicked();

    void on_actionSave_triggered();

    void on_actionNew_triggered();

    void on_actionLoad_triggered();

    void on_load_btn_clicked();

    void on_actionAbout_triggered();

    void on_pushButton_clicked();

private:
    Ui::qWSEditor *ui;
    QPalette m_selected_col;
    Settings *m_settings;
};
#endif // QWSEDITOR_H
