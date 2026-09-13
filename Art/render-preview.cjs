const fs=require('fs'),path=require('path'),http=require('http');
const {chromium}=require('playwright'),sharp=require('sharp');
const root=path.resolve(__dirname,'..');
const palette=JSON.parse(fs.readFileSync(path.join(__dirname,'preview-palette.json')));
const lum=rgb=>rgb.map(v=>v/255).map(v=>v<=.04045?v/12.92:((v+.055)/1.055)**2.4).reduce((a,v,i)=>a+v*[.2126,.7152,.0722][i],0);
const hex=s=>s.slice(1).match(/../g).map(v=>parseInt(v,16));
const ratio=(a,b)=>(Math.max(a,b)+.05)/(Math.min(a,b)+.05);
(async()=>{
 const server=http.createServer((req,res)=>{const file=path.resolve(root,'.'+decodeURIComponent(req.url.split('?')[0]));if(!file.startsWith(root+path.sep)){res.writeHead(403).end();return;}fs.readFile(file,(e,data)=>{if(e){res.writeHead(404).end();return;}res.setHeader('Content-Type',file.endsWith('.html')?'text/html':file.endsWith('.json')?'application/json':file.endsWith('.png')?'image/png':'text/xml');res.end(data);});});
 await new Promise(r=>server.listen(0,'127.0.0.1',r));
 const browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 try {
 const page=await browser.newPage({viewport:{width:896,height:504},deviceScaleFactor:1});
 await page.goto(`http://127.0.0.1:${server.address().port}/Art/preview.html`);await page.evaluate(()=>window.ready);
 const boxes=await page.evaluate(()=>Object.fromEntries(['h1','p','.version'].map(s=>{const r=document.querySelector(s).getBoundingClientRect();return [s,{x:r.x,y:r.y,width:r.width,height:r.height}]})));
 const cdp=await page.context().newCDPSession(page);await cdp.send('DOM.enable');await cdp.send('CSS.enable');
 const doc=await cdp.send('DOM.getDocument'); const fonts={};
 for(const s of ['h1','p','.version']) {const {nodeId}=await cdp.send('DOM.querySelector',{nodeId:doc.root.nodeId,selector:s});fonts[s]=(await cdp.send('CSS.getPlatformFontsForNode',{nodeId})).fonts;}
 const output=path.join(root,'Mod/About/Preview.png');const shot=await page.screenshot();await sharp(shot).png({compressionLevel:9}).toFile(output);
 await sharp(shot).resize(268).png().toFile(path.join(__dirname,'preview-268.png'));
 await page.addStyleTag({content:'.copy,.version{visibility:hidden}'});
 const bg=await page.screenshot();await fs.promises.writeFile(path.join(__dirname,'preview-background.png'),bg);
 const {data,info}=await sharp(bg).removeAlpha().raw().toBuffer({resolveWithObject:true});const contrasts={};
 for(const selector of ['h1','p']){const b=boxes[selector];let min=Infinity;for(let y=Math.floor(b.y);y<Math.ceil(b.y+b.height);y++)for(let x=Math.floor(b.x);x<Math.ceil(b.x+b.width);x++){const i=(y*info.width+x)*info.channels;min=Math.min(min,ratio(lum(hex(palette.inkPrimary)),lum([...data.slice(i,i+3)])));}contrasts[selector]=min;}
 contrasts.badge=ratio(lum(hex(palette.badgeInk)),lum(hex(palette.accent)));
 const report={dimensions:[896,504],thumbnailWidth:268,bytes:fs.statSync(output).size,fonts,boxes,contrasts,tag:'absent by recorded decision',version:await page.locator('.version').textContent()};
 fs.writeFileSync(path.join(__dirname,'preview-qa.json'),JSON.stringify(report,null,2)+'\n');console.log(JSON.stringify(report,null,2));
 if(Object.values(contrasts).some(v=>v<4.5)||report.bytes>=900000)throw Error('Preview QA failed');
 } finally {await browser.close();server.close();}
})().catch(e=>{console.error(e);process.exitCode=1});
