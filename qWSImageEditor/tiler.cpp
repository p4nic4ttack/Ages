#include "tiler.h"

Tiler::Tiler(QWidget *parent)
    : QWidget{parent}
{
    m_selected = new QMap<QPoint, QColor>;
    m_current_col = Qt::white;
    m_size = 16;
    update();
}

void Tiler::paintEvent(QPaintEvent *event){
    QPainter painter(this);
    painter.setBrush(QBrush(Qt::black));
    QPen pen;
    pen.setWidthF(0.5);
    pen.setColor(Qt::white);
    painter.setPen(pen);
    painter.drawRect(1,1, (m_size*32)-1, (m_size*32)-1);
    for(int i = 0; i < m_size; i++){
        painter.drawLine(QLine((i*32), 1, (i*32), (m_size*32)-1));
        painter.drawLine(QLine(0,(i*32), (m_size*32)-1, (i*32)));
    }
    QMap<QPoint, QColor>::const_iterator it;
    for (it = m_selected->constBegin(); it != m_selected->constEnd(); ++it) {
        //qDebug() << it.key() << " " << it.value().toRgb();
        painter.setBrush(QBrush(it.value()));
        pen.setWidth(0);
        painter.setPen(pen);
        painter.drawRect(it.key().x()*32,it.key().y()*32, 32, 32);
    }

}

void Tiler::setCurrentCol(const QColor col){
    m_current_col = col;
}

void Tiler::mouseReleaseEvent(QMouseEvent *event){
    QPoint tmp(event->pos().x()/32,event->pos().y()/32);
    if(!m_selected->contains(tmp)){
        m_selected->insert(tmp, m_current_col);
    }else{
        if(m_selected->value(tmp) == m_current_col){
            m_selected->remove(tmp);
        }else{
           m_selected->remove(tmp);
           m_selected->insert(tmp, m_current_col);
        }

    }
    update();
}

void Tiler::save(bool toHex, bool toArray, bool toPng, bool saveBinTxt, bool monochrome, QString path){
    QString filename = QFileDialog::getSaveFileName(this, "Enter save file name", path);
    qDebug() << monochrome;
    if(toArray){
        QFile fp(filename + ".c");
        if(!fp.open(QIODevice::WriteOnly)){
            qDebug() << "Could not create " << filename << ".c";
            return;
        }
        QString array_text;
        if(monochrome)
            array_text = "uint8_t " + filename.split("\/").last() + "[768] = { ";
        else
            array_text = "uint8_t " + filename.split("\/").last() + "[256] = { ";
        for(int y = 0; y < 16; y++){
            for(int x = 0; x < 16; x++){
                QPoint tmp;
                if((y%2)==0)
                    tmp = QPoint(15-x,y);
                else
                    tmp = QPoint(x,y);
                if(m_selected->contains(tmp)){
                    if(!monochrome){
                        uint8_t g = m_selected->value(tmp).green();
                        char hexG[5];
                        std::sprintf(hexG, "0x%02X", g);
                        uint8_t r = m_selected->value(tmp).red();
                        char hexR[5];
                        std::sprintf(hexR, "0x%02X", r);
                        uint8_t b = m_selected->value(tmp).blue();
                        char hexB[5];
                        std::sprintf(hexB, "0x%02X", b);
                        array_text += QString(hexG) + ", " + QString(hexR) + ", " + QString(hexB) + ", ";
                    }else{
                        array_text += "0xff, ";
                    }
                }else{
                   if(!monochrome)
                       array_text += "0x00, 0x00, 0x00, ";
                   else {
                       array_text += "0x00, ";
                   }
                }
            }
        }
        array_text += "};";
        QTextStream ds(&fp);
        ds << array_text;
        fp.close();
    }
    if(toPng){
        //QFile fp(filename + ".png");
        QImage image ((m_size*32), (m_size*32), QImage::Format_ARGB32);
        QPainter painter(&image);
        painter.setBrush(QBrush(Qt::black));
        QPen pen;
        pen.setWidthF(0.5);
        pen.setColor(Qt::white);
        painter.setPen(pen);
        painter.drawRect(1,1, (m_size*32), (m_size*32));
        for(int i = 0; i < 16; i++){
            painter.drawLine(QLine((i*32), 1, (i*32), (m_size*32)-1));
            painter.drawLine(QLine(0,(i*32), (m_size*32)-1, (i*32)));
        }
        QMap<QPoint, QColor>::const_iterator it;
        for (it = m_selected->constBegin(); it != m_selected->constEnd(); ++it) {
            painter.setBrush(QBrush(it.value()));
            pen.setWidth(0);
            painter.setPen(pen);
            painter.drawRect(it.key().x()*32,it.key().y()*32, 32, 32);
        }
        image.save(filename + ".png");
    }
    if(toHex){
        QFile fp(filename + ".bin");
        if(!fp.open(QIODevice::WriteOnly)){
            qDebug() << "Could not create " << filename << ".bin";
            return;
        }
        QByteArray data;
        for(int y = 0; y < m_size; y++){
            for(int x = 0; x < m_size; x++){
                QPoint tmp;
                if((y%2)==0)
                    tmp = QPoint((m_size-1)-x,y);
                else
                    tmp = QPoint(x,y);
                if(m_selected->contains(tmp)){
                    if(!monochrome){
                        uint8_t g = m_selected->value(tmp).green();
                        uint8_t r = m_selected->value(tmp).red();
                        uint8_t b = m_selected->value(tmp).blue();
                        data.append((char)g);
                        data.append((char)r);
                        data.append((char)b);
                    }else{
                        data.append((char)0xff);
                    }
                }else{
                    if(!monochrome){
                        data.append((char)0x00);
                        data.append((char)0x00);
                        data.append((char)0x00);
                    }else{
                        data.append((char)0x00);
                    }
                }
            }
        }
        fp.write(data);
        fp.close();
    }
    if(saveBinTxt){
        QMap<QPoint, QColor>::const_iterator it;
        for (it = m_selected->constBegin(); it != m_selected->constEnd(); ++it) {
            qDebug() << it.key();
        }
        QFile fp(filename + "-binary.txt");
        if(!fp.open(QIODevice::WriteOnly)){
            qDebug() << "Could not create " << filename << "-binary.txt";
            return;
        }
        QTextStream ds(&fp);
        QString binary_text = "";
        for(int y = 0; y < m_size; y++){
            for(int x = 0; x < m_size; x++){
                QPoint tmp;
                if((y%2)==0)
                    tmp = QPoint((m_size-1)-x,y);
                else
                    tmp = QPoint(x,y);
                if(m_selected->contains(tmp)){
                    if(!monochrome)
                        binary_text += byte_to_binary_string(m_selected->value(tmp).green()) + byte_to_binary_string(m_selected->value(tmp).red()) + byte_to_binary_string(m_selected->value(tmp).blue());
                    else
                        binary_text += "1";
                }else{
                    if(!monochrome)
                        binary_text += "000000000000000000000000";
                    else
                        binary_text += "0";
                }

            }
        }
        ds << binary_text;
        fp.close();

    }
}

void Tiler::load(QString path){
    QString filename = QFileDialog::getOpenFileName(this, "Load from file", path);
    QFile *fh = new QFile(filename);
    if(!fh->open(QIODevice::ReadOnly)){
        qDebug() << "Cannot open " << filename;
        return;
    }
    QTextStream input(fh);
    QString data = input.readAll();
    fh->close();
    int x_count = 0;
    int y_count = 0;
    clear();
    for(int i = 0; i < data.length();i+=24){

        QString chunk = data.mid(i,24);
        QColor tmp_col(chunk.mid(8,8).toUInt(nullptr,2), chunk.mid(0,8).toInt(nullptr,2), chunk.mid(16,8).toUInt(nullptr,2));
        if(tmp_col != QColor(0,0,0)){
            if(y_count%2==0){
                m_selected->insert(QPoint((m_size-1)-x_count,y_count), tmp_col);
            }else{
                m_selected->insert(QPoint(x_count,y_count), tmp_col);
            }
        }
        x_count += 1;
        if((x_count%m_size)==0){
            x_count = 0;
            y_count += 1;
        }

    }
    update();
}

QString Tiler::byte_to_binary_string(uint8_t byte) const{
    QString result;
    for(uint8_t i = 0; i < 8; i++){
        if(byte & (1<<7-i)){
            result += '1';
        }else{
            result += '0';
        }
    }
    return result;
}

void Tiler::clear(){
    m_selected->clear();
    update();
}

void Tiler::setSize(uint8_t size){
    this->m_size = size;
    update();
}

void Tiler::fillAll(){
    m_selected->clear();
    for(int y = 0; y < m_size; y++){
        for(int x = 0; x < m_size; x++){
            m_selected->insert(QPoint(x,y), m_current_col);
        }
    }
    update();
}

bool operator<(const QPoint p1, const QPoint p2){
    if(p1.x()<p2.x())
        return true;
    else if(p1.x() > p2.x())
        return false;
    else
        return p1.y() < p2.y();
}
