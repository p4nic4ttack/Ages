#include "settings.h"
#include "ui_settings.h"

Settings::Settings(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Settings)
{
    ui->setupUi(this);
    save_to_array = true;
    save_to_hex = true;
    save_to_png = true;
    save_bintxt = true;
    size = 16;
    save_dir = QCoreApplication::applicationDirPath();
}

void Settings::showEvent(QShowEvent *event){
    ui->save_array->setChecked(save_to_array);
    ui->save_hex->setChecked(save_to_hex);
    ui->save_png->setChecked(save_to_png);
    ui->checkBox->setChecked(save_bintxt);
    ui->width->setMinimum(1);
    ui->width->setMaximum(16);
    ui->width->setValue(size);
    ui->save_dir_lbl->setText(save_dir);
    this->show();
}

Settings::~Settings()
{
    delete ui;
}

void Settings::on_pushButton_clicked()
{
    save_to_array = ui->save_array->isChecked();
    save_to_hex = ui->save_hex->isChecked();
    save_to_png = ui->save_png->isChecked();
    save_bintxt = ui->checkBox->isChecked();
    monochrome = ui->checkBox_2->isChecked();
    /*if(monochrome){
        ui->save_array->setDisabled(true);
        ui->save_hex->setDisabled(true);
        ui->checkBox->setDisabled(true);
    }else{
        ui->save_array->setDisabled(false);
        ui->save_hex->setDisabled(false);
        ui->checkBox->setDisabled(false);
    }*/
    if(size != ui->width->value()){
        size = ui->width->value();
        emit sizeChanged();
    }
    this->close();
}

bool Settings::getSaveToArray() const{
    return save_to_array;
}

bool Settings::getSaveToHex() const{
    return save_to_hex;
}

bool Settings::getSaveToPng() const{
    return save_to_png;
}

bool Settings::getSaveBinTxt() const{
    return save_bintxt;
}

void Settings::on_pushButton_2_clicked()
{
    QString path = QFileDialog::getExistingDirectory(this, "Choose saving directory");
    save_dir = path;
    ui->save_dir_lbl->setText(save_dir);
}

QString Settings::getSaveDir() const{
    return this->save_dir;
}

uint8_t Settings::getSize() const{
    return this->size;
}

bool Settings::getSaveMonochrome() const{
    return this->monochrome;
}
