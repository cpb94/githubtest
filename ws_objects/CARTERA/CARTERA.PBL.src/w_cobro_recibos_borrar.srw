$PBExportHeader$w_cobro_recibos_borrar.srw
forward
global type w_cobro_recibos_borrar from w_int_con_empresa
end type
type pb_1 from upb_salir within w_cobro_recibos_borrar
end type
type cb_procesar from commandbutton within w_cobro_recibos_borrar
end type
type cb_2 from commandbutton within w_cobro_recibos_borrar
end type
type dw_detalle from datawindow within w_cobro_recibos_borrar
end type
type st_1 from statictext within w_cobro_recibos_borrar
end type
type uo_cliente from u_em_campo_2 within w_cobro_recibos_borrar
end type
type em_asiento from u_em_campo within w_cobro_recibos_borrar
end type
type st_3 from statictext within w_cobro_recibos_borrar
end type
type em_fapunte from u_em_campo within w_cobro_recibos_borrar
end type
type st_4 from statictext within w_cobro_recibos_borrar
end type
type st_11 from statictext within w_cobro_recibos_borrar
end type
type uo_banco from u_em_campo_2 within w_cobro_recibos_borrar
end type
type st_5 from statictext within w_cobro_recibos_borrar
end type
type em_fcobro from u_em_campo within w_cobro_recibos_borrar
end type
type st_6 from statictext within w_cobro_recibos_borrar
end type
type em_divisas from u_em_campo within w_cobro_recibos_borrar
end type
type uo_ejercicio from u_ejercicio within w_cobro_recibos_borrar
end type
type cb_salir from commandbutton within w_cobro_recibos_borrar
end type
type cb_borrar from commandbutton within w_cobro_recibos_borrar
end type
type st_22 from statictext within w_cobro_recibos_borrar
end type
type uo_moneda from u_em_campo_2 within w_cobro_recibos_borrar
end type
type st_moneda from statictext within w_cobro_recibos_borrar
end type
type em_importe from u_em_campo within w_cobro_recibos_borrar
end type
type st_pts from statictext within w_cobro_recibos_borrar
end type
type em_cambio from u_em_campo within w_cobro_recibos_borrar
end type
type st_7 from statictext within w_cobro_recibos_borrar
end type
type em_total from u_em_campo within w_cobro_recibos_borrar
end type
type em_gastos from u_em_campo within w_cobro_recibos_borrar
end type
type st_pts2 from statictext within w_cobro_recibos_borrar
end type
type st_9 from statictext within w_cobro_recibos_borrar
end type
type ln_1 from line within w_cobro_recibos_borrar
end type
type st_pts3 from statictext within w_cobro_recibos_borrar
end type
type st_8 from statictext within w_cobro_recibos_borrar
end type
type dw_selecion from u_datawindow_consultas within w_cobro_recibos_borrar
end type
type gb_1 from groupbox within w_cobro_recibos_borrar
end type
end forward

global type w_cobro_recibos_borrar from w_int_con_empresa
integer x = 27
integer y = 4
integer width = 2894
integer height = 2220
pb_1 pb_1
cb_procesar cb_procesar
cb_2 cb_2
dw_detalle dw_detalle
st_1 st_1
uo_cliente uo_cliente
em_asiento em_asiento
st_3 st_3
em_fapunte em_fapunte
st_4 st_4
st_11 st_11
uo_banco uo_banco
st_5 st_5
em_fcobro em_fcobro
st_6 st_6
em_divisas em_divisas
uo_ejercicio uo_ejercicio
cb_salir cb_salir
cb_borrar cb_borrar
st_22 st_22
uo_moneda uo_moneda
st_moneda st_moneda
em_importe em_importe
st_pts st_pts
em_cambio em_cambio
st_7 st_7
em_total em_total
em_gastos em_gastos
st_pts2 st_pts2
st_9 st_9
ln_1 ln_1
st_pts3 st_pts3
st_8 st_8
dw_selecion dw_selecion
gb_1 gb_1
end type
global w_cobro_recibos_borrar w_cobro_recibos_borrar

type variables
date var_fechalimite
STring  conexion = "N"
dec total_selec,total_por
int total_reg

end variables

forward prototypes
public subroutine f_control ()
public function boolean f_procesar_recibos (integer i)
public subroutine f_pro ()
public subroutine f_control2 ()
public subroutine f_activar (boolean bo)
public function boolean f_grabar_apunte ()
end prototypes

public subroutine f_control ();dw_detalle.Reset()
string is_filtro=""
dec registros,r,re
dw_detalle.SetTransObject(sqlca)
dw_detalle.SetFilter("")
dw_detalle.Filter()

string f="",fi=""
if tipo_vista="Nacional" then fi="(nacional='S')"
if tipo_vista="Exportacion" then fi="(nacional='N')"
if tipo_vista="Ambos" then fi="((nacional='N') or (nacional='S'))"
f=fi
dw_detalle.SetFilter(f)
dw_detalle.Filter()
dw_detalle.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,uo_moneda.em_codigo.text,Dec(em_cambio.text))

f_control2()


end subroutine

public function boolean f_procesar_recibos (integer i);int  bien = 0
Dec camb,j1,v_gastos_fletes,v_cambiofra,v_comision,v_comisionliqui,v_comisionliquipts
Dec fac,v_baseliqui,v_baseliquipts,v_comisiones
camb = Dec(em_cambio.text)
string borrar,v_moneda
dec anyo_efecto,orden_efecto,linea_efecto
str_carhistorico historico
anyo_efecto=dw_selecion.GetItemnumber(i,"anyo")
orden_efecto=dw_selecion.GetItemnumber(i,"orden")
	dec importe_nuevo
	importe_nuevo=dw_selecion.GetItemnumber(i,"cancelado_divisas")
	// Selecciono datos del efecto y los inserto en carhistorico

	  SELECT	carefectos.anyofra,carefectos.factura,carefectos.recibo,
				carefectos.fvto, carefectos.ffra, carefectos.fvto_original, 
      	   carefectos.importe,carefectos.divisas,carefectos.monedas,
				carefectos.fpago,carefectos.tipodoc,carefectos.banco,   
	         carefectos.remesa,carefectos.fremesa,
   	      carefectos.agente1,carefectos.pais,carefectos.cuenta,   
	         carefectos.domiciliacion,carefectos.Nacional,
				carefectos.observaciones,carefectos.libre,carefectos.gasto,   
      	   carefectos.fdevolucion,carefectos.agrupado,   
	         carefectos.efectoagrupa,carefectos.anyoagrupa,
				carefectos.cliente,carefectos.anyo_remesa ,
				carefectos.comision11,carefectos.comision12,carefectos.comision21,
				carefectos.comision22,carefectos.comision31,carefectos.comision32,
				carefectos.agente2,carefectos.agente3,carefectos.cambio,carefectos.serie
   	 INTO :historico.anyofra,:historico.factura,:historico.recibo,   
	         :historico.fvto,:historico.ffra, :historico.fvto_original,
				:historico.importe,:historico.divisas,:historico.monedas,   
	         :historico.fpago,:historico.tipodoc,:historico.banco,   
	         :historico.remesa,:historico.fremesa,  
	         :historico.agente1,:historico.pais,:historico.cuenta,   
	         :historico.domiciliacion,:historico.nacional,   
	         :historico.observaciones,:historico.libre,:historico.gasto,   
	         :historico.fdevolucion,:historico.agrupado,
				:historico.efectoagrupa,:historico.anyoagrupa,   
	         :historico.cliente,:historico.anyo_remesa,
				:historico.comision11,:historico.comision12,:historico.comision21,
				:historico.comision22,:historico.comision31,:historico.comision32,
				:historico.agente2,:historico.agente3,:historico.cambio,:historico.serie
   FROM  carefectos  
   WHERE carefectos.empresa = :codigo_empresa
	AND   carefectos.anyo    = :anyo_efecto
	AND   carefectos.orden   = :orden_efecto;
	IF SQLCA.SQLCODE <> 0 Then bien = 1		
	
	
	IF IsNull(historico.agrupado) or Trim(historico.agrupado)= "" Then
		historico.agrupado= "N"
	END IF
	IF historico.agrupado<>"S" then
   historico.cambio_cobro = camb		
	historico.empresa   = codigo_empresa
	historico.anyo      = anyo_efecto 
	historico.orden     = orden_efecto
	historico.situacion = "9"
	historico.fcobro    = datetime(date(em_fcobro.text))
	IF historico.divisas<>importe_nuevo then
			integer opcion
			opcion=messagebox("Fra. "+historico.factura+" cancelada en parte"," Desea anular el resto.",question!,yesno!)
			CHOOSE CASE opcion
				case 1
					historico.divisas=importe_nuevo
					historico.importe=importe_nuevo * camb
					borrar="SI"
				case 2
					historico.divisas=importe_nuevo
					historico.importe=importe_nuevo * camb
					borrar="NO"
				case else
					borrar="SI"
			end choose
		else
			borrar="SI"
		end if
	SELECT max(carhistorico.linea )   INTO :linea_efecto    FROM carhistorico  
   WHERE  carhistorico.empresa = :codigo_empresa 
	AND    carhistorico.anyo    = :anyo_efecto 
	AND    carhistorico.orden   = :orden_efecto ;
	if sqlca.sqlcode=100 then linea_efecto=0
	if isnull(linea_efecto) then linea_efecto=0
	historico.linea=linea_efecto + 1
	
	if not f_insert_carhistorico(historico) then bien=1

	// Borro el efecto de carefectos
	if borrar="SI" then
		DELETE FROM carefectos  
   	WHERE carefectos.empresa = :codigo_empresa
		AND   carefectos.anyo = :anyo_efecto 
		AND  	carefectos.orden = :orden_efecto;
		IF SQLCA.SQLCODE <> 0 Then bien = 1
	else
		UPDATE carefectos
		SET    carefectos.divisas=carefectos.divisas - :importe_nuevo,
				 carefectos.importe=(carefectos.divisas - :importe_nuevo) * :camb
	 	WHERE  carefectos.empresa = :codigo_empresa 
		 AND   carefectos.anyo = :anyo_efecto 
		 AND   carefectos.orden = :orden_efecto;
		IF SQLCA.SQLCODE <> 0 Then bien = 1
	end if
ELSE		
	// Si el efecto es agrupado proceso el detalle
		integer det_registros
		String sel
		DataStore   dw_cursor_agrupados
		
		sel = " Select * from carefectos " + &
		      " where carefectos.empresa       =  '"+ codigo_empresa +"'"+&
		      " And   carefectos.situacion     =  '3' " + &
				" And   carefectos.anyoagrupa    =  " + String(anyo_efecto,"####") +&
				" And   carefectos.efectoagrupa  =  " + STRING(orden_efecto,"####") 
		
		//dw_cursor_agrupados= f_cargar_cursor2(sel)
		f_cargar_cursor_nuevo(sel, dw_cursor_Agrupados)
		det_registros=dw_cursor_agrupados.rowcount()
				// Selecciono datos del efecto y los inserto en carhistorico
		integer r
		dec det_anyo_efecto,det_orden_efecto,det_linea_efecto
		str_carhistorico det_historico
		IF det_registros = 0 Then
			f_mensaje("Error","no hay registros como recibos agrupado")
			bien = 1
		END IF
		for r=1 to det_registros
			det_anyo_efecto  =dw_cursor_agrupados.GetItemNumber(r,"anyo")
			det_orden_efecto =dw_cursor_agrupados.GetItemNumber(r,"orden")
	  		
	  		SELECT 
	  		carefectos.anyofra,carefectos.factura,carefectos.recibo,
			carefectos.fvto, carefectos.ffra, carefectos.fvto_original,
         carefectos.importe,carefectos.divisas,carefectos.monedas,
			carefectos.fpago,carefectos.tipodoc,carefectos.banco,   
         carefectos.remesa,carefectos.fremesa,
         carefectos.agente1,carefectos.pais,carefectos.cuenta,   
         carefectos.domiciliacion,carefectos.Nacional,
			carefectos.observaciones,carefectos.libre,carefectos.gasto,   
         carefectos.fdevolucion,carefectos.agrupado,   
         carefectos.efectoagrupa,carefectos.anyoagrupa,
			carefectos.cliente,carefectos.anyo_remesa  
    		INTO
			:det_historico.anyofra,:det_historico.factura,:det_historico.recibo,   
         :det_historico.fvto,:det_historico.ffra, :historico.fvto_original,
			:det_historico.importe,:det_historico.divisas,:det_historico.monedas,   
         :det_historico.fpago,:det_historico.tipodoc,:det_historico.banco,   
         :det_historico.remesa,:det_historico.fremesa,  
         :det_historico.agente1,:det_historico.pais,:det_historico.cuenta,   
         :det_historico.domiciliacion,:det_historico.nacional,   
         :det_historico.observaciones,:det_historico.libre,:det_historico.gasto,   
         :det_historico.fdevolucion,:det_historico.agrupado,
			:det_historico.efectoagrupa,:det_historico.anyoagrupa,   
         :det_historico.cliente,:det_historico.anyo_remesa  
    		FROM carefectos  
   		WHERE ( carefectos.empresa = :codigo_empresa ) AND  
        			( carefectos.anyo  = :det_anyo_efecto ) AND  
         		( carefectos.orden = :det_orden_efecto )   ;
			IF SQLCA.SQLCODE <> 0 Then bien = 1
			det_historico.empresa=codigo_empresa
			det_historico.anyo=det_anyo_efecto 
			det_historico.orden=det_orden_efecto
			det_historico.fcobro=historico.fcobro
			det_historico.situacion="3"
	  		SELECT max(carhistorico.linea )  
    		INTO :det_linea_efecto  
    		FROM carhistorico  
   		WHERE ( carhistorico.empresa = :codigo_empresa ) AND  
         		( carhistorico.anyo = :det_anyo_efecto ) AND  
         		( carhistorico.orden = :det_orden_efecto )   ;
			if sqlca.sqlcode=100 then det_linea_efecto=0
			if isnull(det_linea_efecto) then det_linea_efecto=0
			det_historico.linea=det_linea_efecto + 1
			
			if not f_insert_carhistorico(det_historico) then bien=1
					
			// borro el detalle de carefectos

 		 	DELETE FROM carefectos  
   		WHERE carefectos.empresa = :codigo_empresa 
			AND   carefectos.anyo = :det_anyo_efecto 
			AND   carefectos.orden = :det_orden_efecto    ;
			IF SQLCA.SQLCODE <> 0 Then bien = 1
		next
	end if
//  Fin cancelacion agrupados


	// COMPRUEBO SI QUEDA ALGÚN RECIBO POR COBRAR
	long cuantos_recibos
	SELECT COUNT(carefectos.recibo)  
   INTO :cuantos_recibos  
   FROM carefectos  
   WHERE ( carefectos.empresa = :codigo_empresa ) AND  
         ( carefectos.anyofra = :historico.anyofra ) AND  
         ( carefectos.factura = :historico.factura )   ;
		if sqlca.sqlcode=100 or cuantos_recibos=0 or isnull(cuantos_recibos) then
			// PASO A CARCOMISIONES COMO COBRADO

			fac=Dec(historico.factura)


	Select sum(carhistorico.divisas),sum(carhistorico.importe) 
	Into   :v_baseliqui,:v_baseliquipts From carhistorico
	Where  carhistorico.empresa = :codigo_empresa
	And    carhistorico.anyo    = :historico.anyofra
	And    carhistorico.factura = :historico.factura
	And    carhistorico.situacion = "9";
	
	//----------------------
	// recalculo comisiones
	//-----------------------
DataStore dw 
String selo
Selo = " Select * From  carcomisiones   " +&
		 " Where  carcomisiones.empresa = '"+codigo_empresa + "'" +&
		 " ANd    carcomisiones.anyo    = "+ String(historico.anyofra,"####") +&
		 " And    carcomisiones.factura = " + String(fac ,"########")
//dw = f_cargar_cursor2(selo)
f_cargar_cursor_nuevo(selo, dw)

// Calculamos porcentaje diferencia de cambio

IF dw.RowCount() <> 0 Then
	For j1 = 1 To dw.RowCount()
		   v_gastos_fletes	 = dw.GetItemNumber(j1,"gastos_fletes")
			v_cambiofra			 = dw.GetItemNumber(j1,"cambiofra")
			v_comision			 = dw.GetItemNumber(j1,"comision")
			v_moneda           = dw.GetItemString(j1,"moneda")
		   v_baseliqui        = Dec(String(v_baseliqui - (v_gastos_fletes/v_cambiofra),f_mascara_moneda(v_moneda)))
			v_baseliqui        = Dec(String(v_baseliquipts - v_gastos_fletes,f_mascara_decimales(0)))
			v_comisionliqui    = Dec(String(v_baseliqui * v_comision / 100,f_mascara_moneda(v_moneda)))
			v_comisionliquipts = Dec(String(v_baseliquipts * v_comision / 100,f_mascara_decimales(0)))
			
			Update carcomisiones 
			Set    carcomisiones.cobrado          = "S",
			       carcomisiones.baseliqui        = :v_baseliqui,
					 carcomisiones.baseliquipts     = :v_baseliquipts,
					 carcomisiones.comisionliqui    = :v_comisionliqui,
					 carcomisiones.comisionliquipts = :v_comisionliquipts
			Where  carcomisiones.empresa = :codigo_empresa
			ANd    carcomisiones.anyo    = :historico.anyofra
			And    carcomisiones.factura = :fac;
			  IF SQLCA.SQLCODE <> 0 Then f_mensaje("Error en fproceso_recibos",sqlca.sqlerrtext)
		Next
	END IF
	END IF
	




destroy dw_cursor_agrupados
destroy dw

IF bien =0 Then
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
end function

public subroutine f_pro ();Integer r , r1,e
r1 = dw_detalle.RowCount()
For r = 1 To r1
	IF dw_detalle.GetItemSTring(r,"libre") = "S" Then
		e = dw_selecion.find("anyo ="+String(dw_detalle.GetItemNumber(r,"anyo"),"####")+" and orden ="+String(dw_detalle.GetItemNumber(r,"orden"),"#####"),1,dw_selecion.RowCount())
      IF e = 0 Then
			e = dw_selecion.RowCOunt() + 1
			dw_selecion.InsertRow(e)
		END IF
		dw_selecion.SetItem(e,"empresa",codigo_empresa)
		dw_selecion.SetItem(e,"anyo",dw_detalle.GetItemNumber(r,"anyo"))
		dw_selecion.SetItem(e,"orden",dw_detalle.GetItemNumber(r,"orden"))
		dw_selecion.SetItem(e,"cliente",dw_detalle.GetItemString(r,"cliente"))
		dw_selecion.SetItem(e,"fra",dw_detalle.GetItemSTring(r,"factura"))
		dw_selecion.SetItem(e,"ffra",dw_detalle.GetItemdateTime(r,"ffra"))
		dw_selecion.SetItem(e,"importe",dw_detalle.GetItemNumber(r,"importe"))
		dw_selecion.SetItem(e,"cancelado",dw_detalle.GetItemNumber(r,"total"))
		dw_selecion.SetItem(e,"cancelado_divisas",dw_detalle.GetItemNumber(r,"nuevo"))
		dw_selecion.SetItem(e,"cambio",dw_detalle.GetItemNumber(r,"cambio"))
		dw_selecion.SetItem(e,"divisas",dw_detalle.GetItemNumber(r,"divisas"))

	END IF
Next
end subroutine

public subroutine f_control2 ();Dec registros,r,re
registros = dw_detalle.RowCount()

For r = 1 To registros
	re = dw_selecion.find("anyo = "+String(dw_detalle.GetItemNumber(r,"anyo"),"#######")+" and orden= "+String(dw_detalle.GetItemNumber(r,"orden"),"#######") ,1,dw_selecion.RowCount())
	IF re <> 0 Then
	dw_detalle.SetItem(r,"nuevo",dw_selecion.GetItemNumber(re,"cancelado"))
	dw_detalle.SetItem(r,"libre","S")
END IF
Next
end subroutine

public subroutine f_activar (boolean bo);em_cambio.enabled = bo
em_divisas.enabled = bo
em_fcobro.enabled = bo
em_gastos.enabled = bo
em_importe.enabled = bo
em_total.enabled = bo
uo_banco.enabled = bo
uo_moneda.enabled = bo
end subroutine

public function boolean f_grabar_apunte ();Integer   bien
Dec acu,i,registros,dif
String  ampli
Str_contaapun apu 
apu.empresa   = codigo_empresa
apu.ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
apu.fapunte   = Datetime(date(em_fapunte.text))
apu.mes = Month(Date(apu.fapunte))
apu.origen = "2"
bien = 0
ampli = "F."
registros=dw_selecion.rowcount()

iF em_asiento.text = "" Then
	apu.asiento     = f_ultimo_asiento(apu.ejercicio,apu.empresa,apu.mes,apu.origen)
	em_asiento.text = STring(apu.asiento,f_mascara_decimales(0))
	apu.apunte      = 1
ELSE
	apu.asiento = Dec(em_asiento.text)
	Select Max(contaapun.apunte) Into :apu.apunte From contaapun
	Where  contaapun.ejercicio = :apu.ejercicio
	And    contaapun.empresa   = :apu.empresa
	And    contaapun.mes       = :apu.mes
	And    contaapun.origen    = :apu.origen
	And    contaapun.asiento   = :apu.asiento;
	apu.apunte = apu.apunte + 1
END IF
apu.moneda = uo_moneda.em_codigo.text
SetNull(apu.fregistro)
SetNull(apu.coste)
SetNull(apu.docpunteo)
SetNull(apu.fvalor)
SetNull(apu.punteado)
SetNull(apu.nif)
SetNull(apu.conciliado)
SetNull(apu.clipro)
SetNull(apu.tipoter)
SetNull(apu.registro)
SetNull(apu.listado)
SetNull(apu.deducible)
SetNull(apu.tipoiva)
SetNull(apu.tipoapu)
SetNull(apu.diario)
SetNull(apu.iva)
apu.imponible = 0
apu.actualizado = "N"
apu.cambio = Dec(em_cambio.text)
apu.divisas = Dec(em_total.text) / apu.cambio 
if dec(em_total.text)>0 then
	apu.debe = Dec(em_total.text)
   apu.haber= 0
else
	apu.debe = 0
   apu.haber= abs(Dec(em_total.text))
End if
apu.concepto = "1"
apu.ampliacion= "Fecha: "+ String(Date(em_fcobro.text),"dd-mm-yy")
apu.documento= ""
apu.factura  = ""
SetNull(apu.ffactura) 
apu.cuenta = f_cuenta_carbancos(codigo_empresa,uo_banco.em_codigo.text)
IF Not f_insert_contaapun(apu) Then bien = 1
acu = 0

// calculamos el total de las facturas
// para calcular porcentaje en comisiones
for i=1 to registros
	total_selec = total_selec + dw_selecion.GetItemNumber(i,"cancelado")
Next

total_por = (dec(em_importe.text)-total_selec)/dec(em_importe.text)*100
f_mensaje("total_selec",string(total_selec))
f_mensaje("total_por",string(total_por))

for i=1 to registros
	IF Not f_procesar_recibos(i) Then bien= 1
	apu.apunte = apu.apunte + 1	
	apu.cambio = dw_selecion.GetItemNumber(i,"cambio")
	apu.divisas = dw_selecion.GetItemNumber(i,"cancelado_divisas")
	apu.debe = 0
	apu.haber= dw_selecion.GetItemNumber(i,"cancelado")
	acu = acu + apu.haber
	apu.concepto = "40"
	apu.ampliacion= "Fecha: "+ String(Date(em_fcobro.text),"dd-mm-yy")
	apu.documento= dw_selecion.GetItemString(i,"fra")
	apu.factura  = dw_selecion.GetItemString(i,"fra")
	ampli = ampli +"-" + apu.factura
	apu.ffactura = dw_selecion.GetItemDateTime(i,"ffra")
	apu.cuenta = f_cuenta_genter(codigo_empresa,"C",dw_selecion.GetItemString(i,"cliente"))
	IF Not f_insert_contaapun(apu) Then bien = 1
	f_contador_procesos(i,registros)
Next


//-----------------------------------------------------------------
IF Dec(em_gastos.text) <> 0 Then
	apu.apunte = apu.apunte + 1	
	apu.cambio = Dec(em_cambio.text)
	apu.divisas = Dec(em_gastos.text) / apu.cambio 
	apu.debe = Dec(em_gastos.text)
	apu.haber= 0
	apu.concepto = ""
	apu.ampliacion= ampli 
	apu.documento= ""
	apu.factura  = ""
	apu.ffactura =DateTime(Date(em_fcobro.text))
	apu.cuenta = "66440900"
	IF Not f_insert_contaapun(apu) Then bien = 1
END IF
//-----------------------------------------------------------------
dif = Dec(em_importe.text) - acu
//-----------------------------------------------------------------
IF dif <> 0 Then
	apu.apunte = apu.apunte + 1	
	apu.cambio = Dec(em_cambio.text)
	apu.divisas = dif / apu.cambio 
	apu.debe = 0
	apu.haber= dif
	apu.concepto = ""
	apu.ampliacion= ampli
	apu.documento= ""
	apu.factura  = ""
	apu.ffactura =DateTime(Date(em_fcobro.text))
	apu.cuenta = "76800000"
	IF Not f_insert_contaapun(apu) Then bien = 1
END IF

total_selec = 0
total_por   = 0
total_reg   = 0

IF bien = 0 Then
	Return True
Else
	Return FALSE
END IF


end function

event close;call super::close;//dw_detalle.reset()
//dw_listado.reset()
end event

event open;call super::open;istr_parametros.s_titulo_ventana="COBROS"
This.title=istr_parametros.s_titulo_ventana
 // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
		conexion= "S"
		f_posicion_inicio(this)
    END IF
uo_moneda.em_codigo.text = f_peseta()
uo_moneda.TriggerEvent("modificado")
em_fcobro.text = String(Today(),"dd-mm-yy")
em_fapunte.text = String(Today(),"dd-mm-yy")
dw_detalle.SetTransObject(SQLCA)
f_mascara_columna(dw_detalle,"nuevo",f_mascara_decimales(2))
f_activar_campo(em_fapunte)

end event

event ue_listar;//dw_report  = dw_listado
//dw_report.SetTransObject(SQLCA)
//Datetime fecha
//dw_report.Retrieve(codigo_empresa,dec(em_anyo.text),em_banco.text,dec(em_remesa.text))
////IF TRIM(filtro)<>"" THEN
//// dw_report.SetFilter(filtro)
//// dw_report.Filter()
////END IF
//CALL Super::ue_listar
end event

on w_cobro_recibos_borrar.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_procesar=create cb_procesar
this.cb_2=create cb_2
this.dw_detalle=create dw_detalle
this.st_1=create st_1
this.uo_cliente=create uo_cliente
this.em_asiento=create em_asiento
this.st_3=create st_3
this.em_fapunte=create em_fapunte
this.st_4=create st_4
this.st_11=create st_11
this.uo_banco=create uo_banco
this.st_5=create st_5
this.em_fcobro=create em_fcobro
this.st_6=create st_6
this.em_divisas=create em_divisas
this.uo_ejercicio=create uo_ejercicio
this.cb_salir=create cb_salir
this.cb_borrar=create cb_borrar
this.st_22=create st_22
this.uo_moneda=create uo_moneda
this.st_moneda=create st_moneda
this.em_importe=create em_importe
this.st_pts=create st_pts
this.em_cambio=create em_cambio
this.st_7=create st_7
this.em_total=create em_total
this.em_gastos=create em_gastos
this.st_pts2=create st_pts2
this.st_9=create st_9
this.ln_1=create ln_1
this.st_pts3=create st_pts3
this.st_8=create st_8
this.dw_selecion=create dw_selecion
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_procesar
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.em_asiento
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.em_fapunte
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.st_11
this.Control[iCurrent+12]=this.uo_banco
this.Control[iCurrent+13]=this.st_5
this.Control[iCurrent+14]=this.em_fcobro
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.em_divisas
this.Control[iCurrent+17]=this.uo_ejercicio
this.Control[iCurrent+18]=this.cb_salir
this.Control[iCurrent+19]=this.cb_borrar
this.Control[iCurrent+20]=this.st_22
this.Control[iCurrent+21]=this.uo_moneda
this.Control[iCurrent+22]=this.st_moneda
this.Control[iCurrent+23]=this.em_importe
this.Control[iCurrent+24]=this.st_pts
this.Control[iCurrent+25]=this.em_cambio
this.Control[iCurrent+26]=this.st_7
this.Control[iCurrent+27]=this.em_total
this.Control[iCurrent+28]=this.em_gastos
this.Control[iCurrent+29]=this.st_pts2
this.Control[iCurrent+30]=this.st_9
this.Control[iCurrent+31]=this.ln_1
this.Control[iCurrent+32]=this.st_pts3
this.Control[iCurrent+33]=this.st_8
this.Control[iCurrent+34]=this.dw_selecion
this.Control[iCurrent+35]=this.gb_1
end on

on w_cobro_recibos_borrar.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_procesar)
destroy(this.cb_2)
destroy(this.dw_detalle)
destroy(this.st_1)
destroy(this.uo_cliente)
destroy(this.em_asiento)
destroy(this.st_3)
destroy(this.em_fapunte)
destroy(this.st_4)
destroy(this.st_11)
destroy(this.uo_banco)
destroy(this.st_5)
destroy(this.em_fcobro)
destroy(this.st_6)
destroy(this.em_divisas)
destroy(this.uo_ejercicio)
destroy(this.cb_salir)
destroy(this.cb_borrar)
destroy(this.st_22)
destroy(this.uo_moneda)
destroy(this.st_moneda)
destroy(this.em_importe)
destroy(this.st_pts)
destroy(this.em_cambio)
destroy(this.st_7)
destroy(this.em_total)
destroy(this.em_gastos)
destroy(this.st_pts2)
destroy(this.st_9)
destroy(this.ln_1)
destroy(this.st_pts3)
destroy(this.st_8)
destroy(this.dw_selecion)
destroy(this.gb_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_cobro_recibos_borrar
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_cobro_recibos_borrar
end type

type st_empresa from w_int_con_empresa`st_empresa within w_cobro_recibos_borrar
integer x = 5
integer width = 2427
integer height = 88
end type

type pb_1 from upb_salir within w_cobro_recibos_borrar
integer x = 2729
integer width = 114
integer height = 96
integer taborder = 0
end type

event clicked;If conexion = "N" Then
	Close (Parent)
Else
	CloseWithReturn(Parent,em_asiento.text)
End If
end event

type cb_procesar from commandbutton within w_cobro_recibos_borrar
event clicked pbm_bnclicked
integer x = 2491
integer y = 1424
integer width = 311
integer height = 80
boolean bringtotop = true
integer textsize = -6
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Procesar"
end type

event clicked;Long 		registros
Integer 	i,bien
Dec  		dif,acu

bien = 0
dif  = 0
f_pro()
registros=dw_selecion.rowcount()
iF registros = 0 Then Return

IF Dec(em_cambio.text) = 1 Then
		IF dw_selecion.GetItemNumber(1,"total_cancelacion") <> Dec(em_importe.text) Then
		   if messagebox("Error en Introduccion de datos","Los totales no coinciden"+char(13)+char(13)+"¿Es diferencia de cambio?",question!,YesNO!,1)<>1 then
		     f_activar_campo(uo_cliente.em_campo)
		     Return
		   End if
   	END IF
END IF
IF Not f_control_fecha_apunte(Dec(uo_ejercicio.em_ejercicio.text),datetime(date(em_fapunte.text))) Then Return
IF Not f_grabar_apunte() Then bien = 1

If bien <> 0  Then
	RollBack;
	f_mensaje("Error en proceso","El proceso no se actualiza(" +sqlca.sqlerrtext+")")
ELSE
	Commit;

END IF
cb_salir.triggerEvent(Clicked!)


end event

type cb_2 from commandbutton within w_cobro_recibos_borrar
integer x = 1166
integer y = 412
integer width = 283
integer height = 76
integer taborder = 90
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Continuar"
end type

event clicked;f_activar_campo(uo_cliente.em_campo)
f_activar(FALSE)
f_control()

end event

type dw_detalle from datawindow within w_cobro_recibos_borrar
integer y = 516
integer width = 2848
integer height = 772
string dataobject = "dw_cobros_recibos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;This.AcceptText()
Dec e,r
IF f_objeto_datawindow(dw_detalle) = "ok" Then f_pro()
IF row <> 0 Then
	r = row
IF f_objeto_datawindow(dw_detalle) = "libre" Then	
IF dw_detalle.GetItemString(row,"libre") = "S" Then
	dw_detalle.SetItem(row,"libre","N")
	   e = dw_selecion.find("anyo ="+String(dw_detalle.GetItemNumber(r,"anyo"),"####")+" and orden ="+String(dw_detalle.GetItemNumber(r,"orden"),"#####"),1,dw_selecion.RowCount())
      IF e <> 0 Then
			dw_selecion.DeleteRow(e)
		END IF
ELSE
	dw_detalle.SetItem(row,"libre","S") 
	dw_detalle.SetFocus()
	dw_detalle.SetRow(row)
	dw_detalle.SetColumn("nuevo")
END IF
END IF
f_pro()
END IF
end event

event itemfocuschanged;This.AcceptText()
f_pro()
end event

event itemchanged;This.AcceptText()
f_pro()
end event

type st_1 from statictext within w_cobro_recibos_borrar
integer x = 14
integer y = 344
integer width = 1280
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "C  l  i  e  n  t  e"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_cobro_recibos_borrar
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 14
integer y = 412
integer width = 1147
integer height = 76
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,'C',uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
dw_detalle.Reset()


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Cliente"
ue_datawindow ="dw_ayuda_clientes"

end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type em_asiento from u_em_campo within w_cobro_recibos_borrar
integer x = 2537
integer y = 408
integer width = 293
integer taborder = 0
boolean enabled = false
alignment alignment = right!
end type

type st_3 from statictext within w_cobro_recibos_borrar
integer x = 2258
integer y = 408
integer width = 279
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string pointer = "\BMP\Mano.cur"
long textcolor = 33554432
long backcolor = 12632256
string text = "Asiento:"
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;em_asiento.text = ""
end event

type em_fapunte from u_em_campo within w_cobro_recibos_borrar
integer x = 2537
integer y = 320
integer width = 293
integer taborder = 0
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_4 from statictext within w_cobro_recibos_borrar
integer x = 2249
integer y = 332
integer width = 288
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F.Apunte:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_11 from statictext within w_cobro_recibos_borrar
integer x = 32
integer y = 108
integer width = 187
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Banco:"
boolean focusrectangle = false
end type

type uo_banco from u_em_campo_2 within w_cobro_recibos_borrar
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 229
integer y = 104
integer width = 1307
integer height = 76
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_banco.em_campo.text=f_nombre_banco(codigo_empresa,uo_banco.em_codigo.text)
If Trim(uo_banco.em_campo.text)="" then
	uo_banco.em_campo.text=""
	uo_banco.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Banco"
ue_datawindow ="dw_ayuda_carbancos"

end event

on uo_banco.destroy
call u_em_campo_2::destroy
end on

type st_5 from statictext within w_cobro_recibos_borrar
integer x = 1554
integer y = 108
integer width = 224
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "F.Cobro:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fcobro from u_em_campo within w_cobro_recibos_borrar
integer x = 1778
integer y = 104
integer width = 288
integer height = 76
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_6 from statictext within w_cobro_recibos_borrar
integer x = 795
integer y = 204
integer width = 224
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Divisas:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_divisas from u_em_campo within w_cobro_recibos_borrar
integer x = 1006
integer y = 192
integer width = 366
integer height = 76
integer taborder = 50
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.##"
end type

event modificado;call super::modificado;em_importe.text = String(dec(em_importe.text),f_mascara_moneda(uo_moneda.em_codigo.text))
em_importe.text = String(Dec(em_divisas.text)*Dec(em_cambio.text),f_mascara_decimales(0))
em_importe.TriggerEvent("modificado")
em_gastos.TriggerEvent("modificado")
end event

type uo_ejercicio from u_ejercicio within w_cobro_recibos_borrar
integer x = 2208
integer y = 120
integer height = 176
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type cb_salir from commandbutton within w_cobro_recibos_borrar
event clicked pbm_bnclicked
integer x = 2491
integer y = 1504
integer width = 311
integer height = 80
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Salir"
end type

event clicked;dw_detalle.Reset()
dw_selecion.Reset()
f_activar(TRUE)
em_cambio.text = ""
em_divisas.text = ""
em_gastos.text = ""
em_importe.text = ""
em_total.text = ""
uo_banco.em_campo.text = ""
uo_cliente.em_campo.text = ""
uo_moneda.em_campo.text = ""
uo_banco.em_codigo.text = ""
uo_cliente.em_codigo.text = ""
uo_moneda.em_codigo.text = ""
f_activar_campo(uo_banco.em_campo)
end event

type cb_borrar from commandbutton within w_cobro_recibos_borrar
event clicked pbm_bnclicked
integer x = 2491
integer y = 1584
integer width = 311
integer height = 80
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Borrar"
end type

event clicked;IF dw_selecion.GetRow() = 0 Then Return
	dw_selecion.DeleteRow(dw_selecion.GetRow())
f_control2()
end event

type st_22 from statictext within w_cobro_recibos_borrar
integer y = 196
integer width = 233
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Moneda:"
boolean focusrectangle = false
end type

type uo_moneda from u_em_campo_2 within w_cobro_recibos_borrar
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 229
integer y = 192
integer width = 219
integer height = 76
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_moneda.em_campo.text=f_nombre_moneda_abr(uo_moneda.em_codigo.text)
st_moneda.text=f_nombre_moneda_abr(uo_moneda.em_codigo.text)
em_cambio.text = String(f_cambio_moneda(uo_moneda.em_codigo.text),f_mascara_decimales(0))
em_divisas.TriggerEvent("modificado")
em_importe.TriggerEvent("modificado")
em_gastos.TriggerEvent("modificado")

If Trim(uo_moneda.em_campo.text)="" then
	uo_moneda.em_campo.text=""
	uo_moneda.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo     = "Selección de Monedas"
ue_datawindow = "dw_ayuda_divisas"
valor_empresa = False
end event

on uo_moneda.destroy
call u_em_campo_2::destroy
end on

type st_moneda from statictext within w_cobro_recibos_borrar
integer x = 1381
integer y = 192
integer width = 242
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_importe from u_em_campo within w_cobro_recibos_borrar
integer x = 1646
integer y = 184
integer width = 421
integer height = 76
integer taborder = 60
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###"
end type

event modificado;call super::modificado;em_gastos.TriggerEvent("modificado")
end event

type st_pts from statictext within w_cobro_recibos_borrar
integer x = 2071
integer y = 200
integer width = 114
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Pts"
boolean focusrectangle = false
end type

type em_cambio from u_em_campo within w_cobro_recibos_borrar
integer x = 489
integer y = 192
integer width = 288
integer height = 76
integer taborder = 40
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###.0000"
end type

event modificado;call super::modificado;em_divisas.TriggerEvent("modificado")
em_importe.TriggerEvent("modificado")
em_gastos.TriggerEvent("modificado")
end event

type st_7 from statictext within w_cobro_recibos_borrar
integer x = 1298
integer y = 284
integer width = 338
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Total Gtos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_total from u_em_campo within w_cobro_recibos_borrar
integer x = 1646
integer y = 368
integer width = 421
integer taborder = 0
boolean bringtotop = true
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = styleraised!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###"
end type

type em_gastos from u_em_campo within w_cobro_recibos_borrar
integer x = 1646
integer y = 268
integer width = 421
integer taborder = 70
boolean bringtotop = true
alignment alignment = right!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###"
end type

event modificado;call super::modificado;em_total.text = String(Dec(em_importe.text) - Dec(em_gastos.text),f_mascara_decimales(0))
end event

type st_pts2 from statictext within w_cobro_recibos_borrar
integer x = 2071
integer y = 284
integer width = 114
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Pts"
boolean focusrectangle = false
end type

type st_9 from statictext within w_cobro_recibos_borrar
integer x = 1454
integer y = 384
integer width = 183
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Total:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ln_1 from line within w_cobro_recibos_borrar
long linecolor = 33554432
integer linethickness = 8
integer beginx = 1646
integer beginy = 360
integer endx = 2066
integer endy = 360
end type

type st_pts3 from statictext within w_cobro_recibos_borrar
integer x = 2071
integer y = 376
integer width = 114
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Pts"
boolean focusrectangle = false
end type

type st_8 from statictext within w_cobro_recibos_borrar
integer x = 434
integer y = 204
integer width = 46
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_selecion from u_datawindow_consultas within w_cobro_recibos_borrar
integer x = 5
integer y = 1328
integer width = 2427
integer height = 664
integer taborder = 0
string dataobject = "dw_cobros_recibos1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_cobro_recibos_borrar
integer x = 2478
integer y = 1388
integer width = 338
integer height = 288
integer textsize = -6
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

