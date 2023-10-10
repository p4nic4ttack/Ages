#include "qwseditor.h"
#include "ui_qwseditor.h"

qWSEditor::qWSEditor(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::qWSEditor)
{
    ui->setupUi(this);
    ui->inv_horizontal->hide();
    ui->inv_vertical->hide();
    m_selected_col.setColor(QPalette::Base,Qt::white);
    ui->col_lbl->setPalette(m_selected_col);
    m_settings = new Settings(this);
    connect(m_settings, &Settings::sizeChanged, this,[=]{
        ui->widget->setSize(m_settings->getSize());
        ui->widget->setMinimumSize(m_settings->getSize()*32, m_settings->getSize()*32);
        ui->widget->setMaximumSize(m_settings->getSize()*32, m_settings->getSize()*32);
    });
}

qWSEditor::~qWSEditor()
{
    delete ui;
}


void qWSEditor::on_col_btn_clicked()
{
    QColor tmp = QColorDialog::getColor(Qt::white, this, "Choose color");
    m_selected_col.setColor(QPalette::Base, tmp);
    ui->col_lbl->setPalette(m_selected_col);
    ui->widget->setCurrentCol(tmp);
}


void qWSEditor::on_actionExit_triggered()
{
    QCoreApplication::exit();
}


void qWSEditor::on_actionEdit_save_settings_triggered()
{
    m_settings->show();
}


void qWSEditor::on_save_btn_clicked()
{
    ui->widget->save(m_settings->getSaveToHex(), m_settings->getSaveToArray(), m_settings->getSaveToPng(), m_settings->getSaveBinTxt(), m_settings->getSaveMonochrome(), m_settings->getSaveDir());
}


void qWSEditor::on_actionSave_triggered()
{
    on_save_btn_clicked();
}


void qWSEditor::on_actionNew_triggered()
{
    ui->widget->clear();
}


void qWSEditor::on_actionLoad_triggered()
{
    ui->widget->load(m_settings->getSaveDir());
}


void qWSEditor::on_load_btn_clicked()
{
    on_actionLoad_triggered();
}


void qWSEditor::on_actionAbout_triggered()
{
    QMessageBox::aboutQt(this);
}


void qWSEditor::on_pushButton_clicked()
{
    ui->widget->fillAll();
}

