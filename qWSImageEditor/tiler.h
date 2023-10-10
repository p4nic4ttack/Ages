#ifndef TILER_H
#define TILER_H

#include <QWidget>
#include <QMap>
#include <QPainter>
#include <QMouseEvent>
#include <QFileDialog>
#include <cstdio>

class Tiler : public QWidget
{
    Q_OBJECT
public:
    explicit Tiler(QWidget *parent = nullptr);
    void setCurrentCol(const QColor col);
    void save(bool,bool,bool,bool,bool,QString);
    void load(QString);
    void setSize(uint8_t);
    void fillAll();
    QString byte_to_binary_string(uint8_t) const;
    void clear();
protected:
    void paintEvent(QPaintEvent *);
    void mouseReleaseEvent (QMouseEvent *);

private:
    QMap<QPoint, QColor> *m_selected;
    QColor m_current_col;
    uint8_t m_size;
signals:

};
bool operator<(const QPoint, const QPoint);
#endif // TILER_H
