$PBExportHeader$w_int_precios_formatos.srw
forward
global type w_int_precios_formatos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_precios_formatos
end type
type dw_proceso from datawindow within w_int_precios_formatos
end type
type cb_continuar from u_boton within w_int_precios_formatos
end type
type cb_procesar from u_boton within w_int_precios_formatos
end type
type cb_salir from u_boton within w_int_precios_formatos
end type
type cb_calidades from u_boton within w_int_precios_formatos
end type
type dw_proceso_cal from datawindow within w_int_precios_formatos
end type
type gb_2 from groupbox within w_int_precios_formatos
end type
type uo_tipo from u_marca_lista within w_int_precios_formatos
end type
type dw_detalle from u_datawindow_consultas within w_int_precios_formatos
end type
end forward

global type w_int_precios_formatos from w_int_con_empresa
integer width = 2784
integer height = 1608
pb_1 pb_1
dw_proceso dw_proceso
cb_continuar cb_continuar
cb_procesar cb_procesar
cb_salir cb_salir
cb_calidades cb_calidades
dw_proceso_cal dw_proceso_cal
gb_2 gb_2
uo_tipo uo_tipo
dw_detalle dw_detalle
end type
global w_int_precios_formatos w_int_precios_formatos

type variables
string filtro
Integer bien
end variables

forward prototypes
public function string f_filter ()
public function boolean f_grabar (string cod_formato, string cod_calidad, decimal precio)
end prototypes

public function string f_filter ();Integer numero,registros,x1,y1
String filtro1,filtro2
y1=0
filtro2 = " "
numero = uo_tipo.dw_marca.RowCount()
IF numero =0 Then return filtro

FOR x1 = 1 To numero
   IF uo_tipo.dw_marca.GetItemString(x1,"marca") = "S" THEN
      y1=y1+1
      IF Trim(filtro2) = "" Then
         filtro1 = " calidad = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
       Else
         filtro1 = " Or calidad = '" + uo_tipo.dw_marca.GetItemString(x1,"codigo") + "'"
      End If
      filtro2 = filtro2  + filtro1
   END IF
NEXT


Return filtro2
end function

public function boolean f_grabar (string cod_formato, string cod_calidad, decimal precio);String var_empresa,var_formato,var_calidad
Dec{0} var_precioventa,estado
DateTime var_fechaalta
estado =0

	  var_empresa       =   codigo_empresa
     var_formato       =   cod_formato
     var_calidad       =   cod_calidad
     var_precioventa   =   precio
     var_fechaalta     =   DateTime(Today(),Now())
	  Select calformato.empresa Into :var_empresa from calformato
	  WHere  calformato.empresa = :codigo_empresa
	  And    calformato.formato = :cod_formato
	  And    calformato.calidad = :cod_calidad;
	  IF SQLCA.SQLCODE = 100 Then
	   INSERT INTO calformato  
             ( empresa,formato,calidad,precioventa,fechaalta )  
      VALUES ( :codigo_empresa, :var_formato,:var_calidad,   
               :var_precioventa,:var_fechaalta )  ;
      IF Sqlca.SqlCode <> 0 Then estado = 1					

	  ELSE
		  UPDATE calformato  
     SET precioventa = :var_precioventa,   
         fechaalta = :var_fechaalta  
   WHERE ( calformato.empresa = :codigo_empresa ) AND  
         ( calformato.formato = :var_formato ) AND  
         ( calformato.calidad = :var_calidad )   ;
			      IF Sqlca.SqlCode <> 0 Then estado = 1					

	  END IF
    
 
IF estado = 0 Then
   RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Mapa precios por formatos"
This.title=istr_parametros.s_titulo_ventana
dw_detalle.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
cb_salir.enabled = False
cb_procesar.enabled = False

f_mascara_columna(dw_detalle,"precio",f_mascara_decimales(0))
Integer x1,registros 
String var_codigo,var_texto,marca
dw_proceso_cal.SetTransObject(SQLCA)
registros=dw_proceso_cal.retrieve(codigo_empresa)

If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = dw_proceso_cal.GetItemString(x1,"codigo")
  var_texto   = dw_proceso_cal.GetItemString(x1,"abreviado")
  marca="S"
  uo_tipo.dw_marca.InsertRow(x1)
  uo_tipo.dw_marca.setitem(x1,"marca",marca)
  uo_tipo.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_tipo.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF

uo_tipo.st_titulo1.text="Calidad"
uo_tipo.st_titulo2.text="Resumido"


end event

on ue_listar;//dw_report  = dw_listado
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//fecha = DateTime(Date(String(sle_fecha.Text)))
//dw_report.retrieve(codigo_empresa,em_tarifa.text,fecha)
//IF TRIM(filtro)<>"" THEN
// dw_report.SetFilter(filtro)
// dw_report.Filter()
//END IF
//CALL Super::ue_listar
end on

on w_int_precios_formatos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_proceso=create dw_proceso
this.cb_continuar=create cb_continuar
this.cb_procesar=create cb_procesar
this.cb_salir=create cb_salir
this.cb_calidades=create cb_calidades
this.dw_proceso_cal=create dw_proceso_cal
this.gb_2=create gb_2
this.uo_tipo=create uo_tipo
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.cb_continuar
this.Control[iCurrent+4]=this.cb_procesar
this.Control[iCurrent+5]=this.cb_salir
this.Control[iCurrent+6]=this.cb_calidades
this.Control[iCurrent+7]=this.dw_proceso_cal
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.uo_tipo
this.Control[iCurrent+10]=this.dw_detalle
end on

on w_int_precios_formatos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_proceso)
destroy(this.cb_continuar)
destroy(this.cb_procesar)
destroy(this.cb_salir)
destroy(this.cb_calidades)
destroy(this.dw_proceso_cal)
destroy(this.gb_2)
destroy(this.uo_tipo)
destroy(this.dw_detalle)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_precios_formatos
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_precios_formatos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_precios_formatos
integer x = 27
integer y = 8
integer width = 1993
end type

type pb_1 from upb_salir within w_int_precios_formatos
integer x = 2569
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_proceso from datawindow within w_int_precios_formatos
boolean visible = false
integer x = 69
integer y = 4
integer width = 1371
integer height = 112
boolean bringtotop = true
string dataobject = "dw_proceso_formatos"
boolean livescroll = true
end type

type cb_continuar from u_boton within w_int_precios_formatos
integer x = 1723
integer y = 156
integer width = 352
integer height = 88
integer taborder = 60
string text = "&Continuar"
end type

event clicked;call super::clicked;Integer  numero
String   var_formato,var_calidad
Dec{0}  var_precioventa
uo_tipo.visible = FALSE


Integer registros,x1
dw_proceso.SetFilter("")
dw_proceso.SetFilter(f_filter())
dw_proceso.Filter()
cb_continuar.enabled   = FALSE
cb_calidades.enabled   = FALSE
  

  dw_detalle.visible = False
  
	
  registros =dw_proceso.retrieve(codigo_empresa)
  FOR x1 = 1 To registros
     var_formato  =     dw_proceso.GetItemString(x1,"formato")
     var_calidad      =  dw_proceso.GetItemString(x1,"calidad")
     var_precioventa  =  dw_proceso.GetItemNumber(x1,"precioventa")
     dw_detalle.InsertRow(x1)
     dw_detalle.SetItem(x1,"formato",f_nombre_formato(codigo_empresa,var_formato))
     dw_detalle.SetItem(x1,"calidad",f_nombre_calidad_abr(codigo_empresa,var_calidad))
     dw_detalle.SetItem(x1,"cod_formato",var_formato)
     dw_detalle.SetItem(x1,"cod_calidad",var_calidad)
	  dw_detalle.SetItem(x1,"precio",var_precioventa)
   
            
   f_contador_procesos(x1,registros)
  NEXT
  
  dw_detalle.SetSort("")
  dw_detalle.SetSort("familia,formato")
  dw_detalle.Sort()
 
  dw_detalle.visible   = TRUE
  cb_procesar.enabled  = TRUE
  cb_salir.enabled     = TRUE
  
  dw_detalle.SetColumn("precio")
  dw_detalle.SetFocus()
 

end event

type cb_procesar from u_boton within w_int_precios_formatos
integer x = 667
integer y = 156
integer width = 352
integer height = 88
integer taborder = 0
string text = "&Procesar"
end type

event clicked;call super::clicked;Integer registros,opcion,x1
dw_detalle.AcceptText()


// Proceso la insercion masiva de la tarifa

bien=0
registros  = dw_detalle.RowCount()
String var_familia,var_formato,var_calidad
Decimal var_precio

For x1 = 1 To registros
      var_formato   =  dw_detalle.GetItemString(x1,"cod_formato") 
      var_calidad   =  dw_detalle.GetItemString(x1,"cod_calidad") 
      var_precio    =  dw_detalle.GetItemNumber(x1,"precio") 
      If IsNull(var_precio) Then var_precio = 0 
         f_grabar(var_formato,var_calidad,var_precio)
         f_contador_procesos(x1,registros)
Next

 CHOOSE CASE bien
	CASE 1
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
	CASE 0
     COMMIT USING SQLCA;
   CASE ELSE
     ROLLBACK USING SQLCA;
     MessageBox("Fin de proceso","Error en proceso no se actualiza",Exclamation!, OK!,1)
  END CHOOSE



cb_salir.TriggerEvent("clicked")

end event

type cb_salir from u_boton within w_int_precios_formatos
integer x = 1019
integer y = 156
integer width = 352
integer height = 88
integer taborder = 0
string text = "&Salir"
end type

event clicked;call super::clicked;cb_continuar.enabled  = TRUE
cb_calidades.enabled  = TRUE
cb_procesar.enabled   = FALSE
cb_salir.enabled      = FALSE
dw_detalle.retrieve()

end event

type cb_calidades from u_boton within w_int_precios_formatos
event clicked pbm_bnclicked
integer x = 1371
integer y = 156
integer width = 352
integer height = 88
integer taborder = 40
string text = "&Calidades"
end type

event clicked;call super::clicked;uo_tipo.visible = TRUE
uo_tipo.dw_marca.SetFocus()
end event

type dw_proceso_cal from datawindow within w_int_precios_formatos
boolean visible = false
integer x = 197
integer y = 24
integer width = 494
integer height = 104
string dataobject = "dw_proceso_calidades"
boolean livescroll = true
end type

type gb_2 from groupbox within w_int_precios_formatos
integer x = 654
integer y = 120
integer width = 1435
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type uo_tipo from u_marca_lista within w_int_precios_formatos
boolean visible = false
integer x = 343
integer y = 360
integer width = 1454
boolean border = false
end type

on uo_tipo.destroy
call u_marca_lista::destroy
end on

type dw_detalle from u_datawindow_consultas within w_int_precios_formatos
integer x = 416
integer y = 272
integer width = 1829
integer height = 1088
integer taborder = 2
string dataobject = "dw_int_precios_fomatos"
borderstyle borderstyle = styleraised!
end type

