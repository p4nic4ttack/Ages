#ifndef SETTINGS_H
#define SETTINGS_H

#include <QDialog>
#include <QFileDialog>

namespace Ui {
class Settings;
}

class Settings : public QDialog
{
    Q_OBJECT

public:
    explicit Settings(QWidget *parent = nullptr);
    ~Settings();
    bool getSaveToArray() const;
    bool getSaveToHex() const;
    bool getSaveToPng() const;
    bool getSaveBinTxt() const;
    bool getSaveMonochrome() const;
    uint8_t getSize() const;
    QString getSaveDir() const;
protected:
    void showEvent(QShowEvent *event);
private slots:
    void on_pushButton_clicked();

    void on_pushButton_2_clicked();


private:
    Ui::Settings *ui;
    bool save_to_array, save_to_hex, save_to_png, save_bintxt, monochrome;
    uint8_t size;
    QString save_dir;
signals:
    void sizeChanged();
};

#endif // SETTINGS_H
